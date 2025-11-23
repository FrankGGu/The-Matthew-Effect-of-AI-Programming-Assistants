#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> divideString(std::string s, int k, char fill) {
        std::vector<std::string> result;
        int n = s.length();

        for (int i = 0; i < n; i += k) {
            std::string current_group;
            if (i + k <= n) {
                current_group = s.substr(i, k);
            } else {
                current_group = s.substr(i);
                while (current_group.length() < k) {
                    current_group += fill;
                }
            }
            result.push_back(current_group);
        }

        return result;
    }
};