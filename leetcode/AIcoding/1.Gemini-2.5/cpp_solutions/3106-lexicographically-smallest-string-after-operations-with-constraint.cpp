#include <string>
#include <algorithm>

class Solution {
public:
    std::string getSmallestString(std::string s, int k) {
        for (char &c : s) {
            if (k <= 0) {
                break;
            }
            int dist_to_a = std::min(c - 'a', 26 - (c - 'a'));
            if (k >= dist_to_a) {
                c = 'a';
                k -= dist_to_a;
            } else {
                c -= k;
                k = 0;
            }
        }
        return s;
    }
};