#include <string>
#include <vector>
#include <algorithm>
#include <functional>

class Solution {
public:
    std::string makeLargestSpecial(std::string s) {
        int count = 0;
        int i = 0;
        std::vector<std::string> res;
        for (int j = 0; j < s.size(); ++j) {
            if (s[j] == '1') {
                count++;
            } else {
                count--;
            }
            if (count == 0) {
                res.push_back("1" + makeLargestSpecial(s.substr(i + 1, j - i - 1)) + "0");
                i = j + 1;
            }
        }
        std::sort(res.begin(), res.end(), std::greater<std::string>());
        std::string result = "";
        for (const std::string& str : res) {
            result += str;
        }
        return result;
    }
};