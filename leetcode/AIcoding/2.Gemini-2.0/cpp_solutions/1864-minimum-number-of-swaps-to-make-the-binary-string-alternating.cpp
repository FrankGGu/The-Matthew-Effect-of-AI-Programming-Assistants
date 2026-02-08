#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSwaps(string s) {
        int n = s.size();
        int zeros = 0;
        int ones = 0;

        for (char c : s) {
            if (c == '0') {
                zeros++;
            } else {
                ones++;
            }
        }

        if (abs(zeros - ones) > 1) {
            return -1;
        }

        int swaps0 = 0;
        int swaps1 = 0;

        if (zeros >= ones) {
            string t = s;
            for (int i = 0; i < n; ++i) {
                if (i % 2 == 0 && t[i] != '0') {
                    swaps0++;
                } else if (i % 2 != 0 && t[i] != '1') {
                    swaps0++;
                }
            }
        } else {
            swaps0 = 1e9;
        }

        if (ones >= zeros) {
            string t = s;
            for (int i = 0; i < n; ++i) {
                if (i % 2 == 0 && t[i] != '1') {
                    swaps1++;
                } else if (i % 2 != 0 && t[i] != '0') {
                    swaps1++;
                }
            }
        } else {
            swaps1 = 1e9;
        }

        return min(swaps0, swaps1);
    }
};