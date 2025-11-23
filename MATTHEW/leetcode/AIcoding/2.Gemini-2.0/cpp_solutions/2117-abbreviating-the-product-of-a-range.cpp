#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string abbreviateProduct(int left, int right) {
        double product = 1.0;
        long long trailingZeros = 0;
        long long mod = 1;
        for (int i = left; i <= right; ++i) {
            product *= i;
            long long num = i;
            while (num % 2 == 0) {
                trailingZeros++;
                num /= 2;
            }
            while (num % 5 == 0) {
                trailingZeros++;
                num /= 5;
            }
        }

        product = 1.0;
        mod = 1;
        for (int i = left; i <= right; ++i) {
            long long num = i;
            while (num % 2 == 0) {
                num /= 2;
            }
            while (num % 5 == 0) {
                num /= 5;
            }
            product *= num;
            product = fmod(product, 1e11);
            mod = 1e5;
            if (product > 1e10) {
                mod = 1e5;
            }
        }

        string s = to_string((long long)product);

        if (s.length() > 10) {
            return s.substr(0, 5) + "..." + s.substr(s.length() - 5) + "e" + to_string(trailingZeros);
        } else {
            return s + "e" + to_string(trailingZeros);
        }
    }
};