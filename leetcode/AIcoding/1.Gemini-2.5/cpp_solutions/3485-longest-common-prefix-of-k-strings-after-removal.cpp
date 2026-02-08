#include <vector>
#include <string>
#include <queue>
#include <unordered_map>
#include <algorithm> // For std::max

struct VectorHasher {
    size_t operator()(const std::vector<int>& v) const {
        size_t hash = v.size();
        for (int i : v) {
            hash ^= i + 0x9e3779b9 + (hash << 6) + (hash >> 2);
        }
        return hash;
    }
};

class Solution {
public:
    int longestCommonPrefix(std::vector<std::string>& strs, int k) {
        int n = strs.size();
        if (n == 0) return 0;

        // Max possible string length is 1000. Use 1001 as a sentinel for "infinity"
        // indicating that a string cannot contribute further characters.
        const int L_INF = 1001; 

        // Precompute next_char[s_idx][char_code][pos]
        // This stores the smallest index >= pos in strs[s_idx] where 'char_code' ('a' to 'z') is found.
        // If not found, it stores L_INF.
        // The size of the last dimension is L_INF + 1 to accommodate indices up to L_INF itself.
        std::vector<std::vector<std::vector<int>>> next_char(n, std::vector<std::vector<int>>(26, std::vector<int>(L_INF + 1)));

        for (int i = 0; i < n; ++i) {
            // Initialize the sentinel value for positions beyond the string length
            for (int char_code = 0; char_code < 26; ++char_code) {
                next_char[i][char_code][strs[i].length()] = L_INF;
            }
            // Populate next_char table from right to left
            for (int j = strs[i].length() - 1; j >= 0; --j) {
                for (int char_code = 0; char_code < 26; ++char_code) {
                    // Inherit the next_char value from the position to the right
                    next_char[i][char_code][j] = next_char[i][char_code][j+1];
                }
                // Update the entry for the character at the current position j
                next_char[i][strs[i][j] - 'a'][j] = j;
            }
        }

        std::queue<std::vector<int>> q;
        std::unordered_map<std::vector<int>, int, VectorHasher> max_len_at_state;

        // Initial state: all strings start searching from index 0, current LCP length is 0
        std::vector<int> initial_indices(n, 0);
        q.push(initial_indices);
        max_len_at_state[initial_indices] = 0;
        int max_overall_len = 0;

        while (!q.empty()) {
            std::vector<int> curr_indices = q.front();
            q.pop();
            int curr_len = max_len_at_state[curr_indices];

            // Try to extend the common prefix with each character 'a' through 'z'
            for (int char_code = 0; char_code < 26; ++char_code) {
                std::vector<int> next_indices(n);
                int count_valid_strings = 0;

                for (int s_idx = 0; s_idx < n; ++s_idx) {
                    // If this string has already exhausted its characters for the current prefix,
                    // it cannot contribute to further extensions.
                    if (curr_indices[s_idx] == L_INF) {
                        next_indices[s_idx] = L_INF;
                        continue;
                    }

                    // Find the next occurrence of the current character ('char_code')
                    // in strs[s_idx] starting from curr_indices[s_idx]
                    int next_pos = next_char[s_idx][char_code][curr_indices[s_idx]];

                    if (next_pos != L_INF) {
                        // Character found: update the next search position for this string
                        // We add 1 because next_pos is 0-indexed, and we need to search
                        // from the position immediately after the found character.
                        next_indices[s_idx] = next_pos + 1;
                        count_valid_strings++;
                    } else {
                        // Character not found: this string cannot form the extended prefix
                        next_indices[s_idx] = L_INF;
                    }
                }

                // If at least 'k' strings can form the extended prefix with the current character
                if (count_valid_strings >= k) {
                    // Check if this new state (next_indices) has been visited with a longer
                    // or equal prefix length. If not, or if we found a longer path, update it.
                    if (max_len_at_state.find(next_indices) == max_len_at_state.end() ||
                        max_len_at_state[next_indices] < curr_len + 1) {

                        max_len_at_state[next_indices] = curr_len + 1;
                        q.push(next_indices);
                        max_overall_len = std::max(max_overall_len, curr_len + 1);
                    }
                }
            }
        }

        return max_overall_len;
    }
};