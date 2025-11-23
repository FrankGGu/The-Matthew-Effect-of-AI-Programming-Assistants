#include <string>
#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    std::vector<std::string> maxNumOfSubstrings(std::string s) {
        int n = s.length();

        std::vector<int> first(26, n);
        std::vector<int> last(26, -1);

        for (int i = 0; i < n; ++i) {
            int char_code = s[i] - 'a';
            if (first[char_code] == n) {
                first[char_code] = i;
            }
            last[char_code] = i;
        }

        std::vector<std::pair<int, int>> candidates;

        for (int i = 0; i < n; ++i) {
            int char_code_i = s[i] - 'a';

            // A valid substring must start with the first occurrence of its first character
            // to satisfy the condition 'first[c] >= i' for s[i] and to be minimal.
            if (first[char_code_i] != i) {
                continue;
            }

            int current_max_end = last[char_code_i];
            bool is_valid_start = true;

            // Expand the substring from 'i' to 'current_max_end'
            // and ensure all characters within this range satisfy the conditions.
            for (int k = i; k <= current_max_end; ++k) {
                int char_code_k = s[k] - 'a';

                // If any character 's[k]' within the current span [i, current_max_end]
                // has its first occurrence before 'i', then this substring cannot be valid
                // starting at 'i'.
                if (first[char_code_k] < i) {
                    is_valid_start = false;
                    break;
                }

                // Extend 'current_max_end' to cover the last occurrence of 's[k]'
                // to satisfy 'last[c] <= j' for all characters 'c' in the substring.
                current_max_end = std::max(current_max_end, last[char_code_k]);
            }

            if (is_valid_start) {
                // If 'is_valid_start' is true, then [i, current_max_end] is a minimal valid substring.
                candidates.push_back({i, current_max_end});
            }
        }

        // Sort candidates by their end points. If end points are equal, sort by length
        // (shorter first) to maximize the number of non-overlapping substrings.
        std::sort(candidates.begin(), candidates.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            if (a.second != b.second) {
                return a.second < b.second;
            }
            return (a.second - a.first) < (b.second - b.first);
        });

        std::vector<std::string> result;
        int last_end_time = -1; // Tracks the end index of the last chosen substring.

        // Greedy selection: pick the substring that ends earliest, then the next non-overlapping.
        for (const auto& p : candidates) {
            if (p.first > last_end_time) {
                result.push_back(s.substr(p.first, p.second - p.first + 1));
                last_end_time = p.second;
            }
        }

        return result;
    }
};