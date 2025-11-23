#include <vector>
#include <string>
#include <map>
#include <set>
#include <algorithm> // For std::sort

class Solution {
public:
    std::vector<std::string> shortestUncommonSubstring(std::vector<std::string>& arr) {
        std::map<std::string, std::set<int>> substring_to_indices;
        int n = arr.size();

        // Step 1: Precompute all substrings from all strings in 'arr'
        // and store the indices of the strings they belong to.
        for (int k = 0; k < n; ++k) {
            const std::string& s = arr[k];
            for (int i = 0; i < s.length(); ++i) {
                for (int j = 1; i + j <= s.length(); ++j) {
                    substring_to_indices[s.substr(i, j)].insert(k);
                }
            }
        }

        std::vector<std::string> result(n);

        // Step 2: For each string arr[i], find its shortest uncommon substring.
        for (int i = 0; i < n; ++i) {
            std::vector<std::string> current_substrings;
            const std::string& s = arr[i];

            // Generate all substrings of the current string arr[i].
            for (int start = 0; start < s.length(); ++start) {
                for (int len = 1; start + len <= s.length(); ++len) {
                    current_substrings.push_back(s.substr(start, len));
                }
            }

            // Sort these substrings: first by length (shortest first),
            // then lexicographically (smallest first).
            std::sort(current_substrings.begin(), current_substrings.end(), 
                      [](const std::string& a, const std::string& b) {
                          if (a.length() != b.length()) {
                              return a.length() < b.length();
                          }
                          return a < b;
                      });

            std::string best_uncommon_substring = "";

            // Iterate through the sorted substrings to find the first one
            // that is uncommon. Since they are sorted, this will be the
            // shortest and lexicographically smallest uncommon substring.
            for (const std::string& sub : current_substrings) {
                // A substring 'sub' is uncommon for arr[i] if:
                // 1. It appears in exactly one string in 'arr'.
                // 2. That string is arr[i] itself.
                if (substring_to_indices[sub].size() == 1 && 
                    *substring_to_indices[sub].begin() == i) {
                    best_uncommon_substring = sub;
                    break; // Found the desired substring, no need to check further.
                }
            }
            result[i] = best_uncommon_substring;
        }

        return result;
    }
};