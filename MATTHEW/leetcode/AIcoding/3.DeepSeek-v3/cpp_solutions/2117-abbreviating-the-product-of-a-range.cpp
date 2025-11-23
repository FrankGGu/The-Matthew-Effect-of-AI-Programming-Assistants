#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    string abbreviateProduct(int left, int right) {
        long long suf = 1;
        double pre = 1.0;
        int count = 0;
        bool large = false;

        for (int i = left; i <= right; ++i) {
            suf *= i;
            pre *= i;
            while (suf % 10 == 0) {
                suf /= 10;
                ++count;
            }
            if (suf >= 1e12) {
                suf %= (long long)1e12;
                large = true;
            }
            while (pre >= 1e12) {
                pre /= 10;
            }
        }

        if (!large && suf < 1e10) {
            return to_string(suf) + "e" + to_string(count);
        } else {
            string s = to_string(suf);
            string leading = to_string((int)pre);
            while (leading.size() > 5) leading.pop_back();
            while (leading.size() < 5) leading = "0" + leading;
            string trailing = s.size() <= 5 ? s : s.substr(s.size() - 5, 5);
            while (trailing.size() < 5) trailing = "0" + trailing;
            return leading + "..." + trailing + "e" + to_string(count);
        }
    }
};