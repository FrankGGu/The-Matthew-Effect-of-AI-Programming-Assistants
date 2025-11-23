#include <string>
#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    bool checkIfCanBreak(std::string s1, std::string s2) {
        std::sort(s1.begin(), s1.end());
        std::sort(s2.begin(), s2.end());

        bool s1_breaks_s2 = true;
        for (int i = 0; i < s1.length(); ++i) {
            if (s1[i] < s2[i]) {
                s1_breaks_s2 = false;
                break;
            }
        }

        if (s1_breaks_s2) {
            return true;
        }

        bool s2_breaks_s1 = true;
        for (int i = 0; i < s2.length(); ++i) {
            if (s2[i] < s1[i]) {
                s2_breaks_s1 = false;
                break;
            }
        }

        return s2_breaks_s1;
    }
};