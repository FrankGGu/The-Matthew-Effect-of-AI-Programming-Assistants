#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minFlipsMonoIncr(string s) {
        int n = s.length();
        int ones = 0;
        int flips = 0;

        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                ones++;
            } else {
                flips++;
            }
            flips = min(flips, ones);
        }

        return flips;
    }
};