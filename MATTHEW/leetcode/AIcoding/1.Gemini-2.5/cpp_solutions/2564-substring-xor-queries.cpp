#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> substringXorQueries(std::string s, std::vector<std::vector<int>>& queries) {
        std::unordered_map<int, std::pair<int, int>> val_to_indices;
        int n = s.length();

        // Iterate through all possible starting positions
        for (int i = 0; i < n; ++i) {
            // If s[i] is '0', it can only represent the value 0.
            // For numbers greater than 0, they must start with '1' to avoid leading zeros
            // and ensure the shortest representation.
            // The problem states s[0] == '1', so s will not be just "0".
            // If a substring is "0", it represents the value 0.
            // If a substring is "01", its value is 1, but "1" is a shorter/earlier representation.
            // Thus, we only consider '0' as a starting point for the value 0 itself.
            // All other non-zero values must start with '1'.
            if (s[i] == '0') {
                if (val_to_indices.find(0) == val_to_indices.end()) {
                    val_to_indices[0] = {i, i};
                }
                // Continue to next character, as '0' cannot start a multi-digit number > 0.
                continue; 
            }

            long long current_val = 0; // Use long long to prevent overflow during calculation
            // The maximum possible XOR result is (1 << 30) - 1, as query values are up to 10^9 < 2^30.
            // So, a substring length of 30 bits is sufficient.
            for (int j = i; j < n && (j - i + 1) <= 30; ++j) {
                current_val = current_val * 2 + (s[j] - '0');

                // If current_val exceeds the maximum possible query target, stop extending.
                if (current_val >= (1LL << 30)) { 
                    break; 
                }

                // Store or update in map based on shortest length, then smallest starting index.
                int val = static_cast<int>(current_val);
                if (val_to_indices.find(val) == val_to_indices.end()) {
                    val_to_indices[val] = {i, j};
                } else {
                    int existing_start = val_to_indices[val].first;
                    int existing_end = val_to_indices[val].second;
                    int existing_len = existing_end - existing_start + 1;
                    int current_len = j - i + 1;

                    if (current_len < existing_len) {
                        val_to_indices[val] = {i, j};
                    } else if (current_len == existing_len) {
                        if (i < existing_start) {
                            val_to_indices[val] = {i, j};
                        }
                    }
                }
            }
        }

        std::vector<std::vector<int>> results;
        results.reserve(queries.size());
        for (const auto& query : queries) {
            int target_val = query[0] ^ query[1];
            if (val_to_indices.count(target_val)) {
                results.push_back({val_to_indices[target_val].first, val_to_indices[target_val].second});
            } else {
                results.push_back({-1, -1});
            }
        }

        return results;
    }
};