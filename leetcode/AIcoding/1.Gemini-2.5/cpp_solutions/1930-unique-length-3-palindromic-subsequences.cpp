#include <string>
#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int countPalindromicSubsequence(std::string s) {
        std::vector<int> first(26, -1);
        std::vector<int> last(26, -1);
        int n = s.length();

        for (int i = 0; i < n; ++i) {
            int char_idx = s[i] - 'a';
            if (first[char_idx] == -1) {
                first[char_idx] = i;
            }
            last[char_idx] = i;
        }

        int count = 0;
        for (int i = 0; i < 26; ++i) {
            if (first[i] != -1 && first[i] < last[i]) {
                std::unordered_set<char> unique_chars;
                for (int j = first[i] + 1; j < last[i]; ++j) {
                    unique_chars.insert(s[j]);
                }
                count += unique_chars.size();
            }
        }

        return count;
    }
};