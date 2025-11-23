#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string sortString(std::string s) {
        std::vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }

        std::string result;
        while (result.size() < s.size()) {
            for (int i = 0; i < 26; i++) {
                if (count[i] > 0) {
                    result += (i + 'a');
                    count[i]--;
                }
            }
            for (int i = 25; i >= 0; i--) {
                if (count[i] > 0) {
                    result += (i + 'a');
                    count[i]--;
                }
            }
        }
        return result;
    }
};