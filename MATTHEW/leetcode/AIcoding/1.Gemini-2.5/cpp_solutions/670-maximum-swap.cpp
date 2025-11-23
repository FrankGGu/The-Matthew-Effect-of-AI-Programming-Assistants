#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumSwap(int num) {
        std::string s = std::to_string(num);
        std::vector<int> last_pos(10, -1);
        for (int i = 0; i < s.length(); ++i) {
            last_pos[s[i] - '0'] = i;
        }

        for (int i = 0; i < s.length(); ++i) {
            for (int d = 9; d > s[i] - '0'; --d) {
                if (last_pos[d] > i) {
                    std::swap(s[i], s[last_pos[d]]);
                    return std::stoi(s);
                }
            }
        }

        return num;
    }
};