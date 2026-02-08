#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string toHex(int num) {
        if (num == 0) return "0";

        unsigned int n = num;
        string hex = "";
        while (n > 0) {
            int rem = n % 16;
            if (rem < 10) {
                hex += to_string(rem);
            } else {
                hex += (char)('a' + (rem - 10));
            }
            n /= 16;
        }

        reverse(hex.begin(), hex.end());
        return hex;
    }
};