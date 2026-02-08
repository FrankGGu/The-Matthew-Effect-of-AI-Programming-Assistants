#include <string>

using namespace std;

class Solution {
public:
    int rotatedDigits(int n) {
        int count = 0;
        for (int i = 1; i <= n; ++i) {
            string s = to_string(i);
            bool valid = false;
            for (char c : s) {
                if (c == '3' || c == '4' || c == '7') {
                    valid = false;
                    break;
                }
                if (c == '2' || c == '5' || c == '6' || c == '9') {
                    valid = true;
                }
            }
            if (valid) {
                count++;
            }
        }
        return count;
    }
};