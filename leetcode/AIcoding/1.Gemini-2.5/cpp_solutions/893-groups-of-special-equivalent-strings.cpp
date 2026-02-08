#include <string>
#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    int numSpecialEquivGroups(std::vector<std::string>& words) {
        std::set<std::string> unique_keys;

        for (const std::string& s : words) {
            std::string even_chars;
            std::string odd_chars;

            for (int i = 0; i < s.length(); ++i) {
                if (i % 2 == 0) {
                    even_chars += s[i];
                } else {
                    odd_chars += s[i];
                }
            }

            std::sort(even_chars.begin(), even_chars.end());
            std::sort(odd_chars.begin(), odd_chars.end());

            unique_keys.insert(even_chars + odd_chars);
        }

        return unique_keys.size();
    }
};