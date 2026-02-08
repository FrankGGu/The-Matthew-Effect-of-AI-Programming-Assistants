#include <string>

using namespace std;

class Solution {
public:
    bool queryString(string s, int n) {
        for (int i = 1; i <= n; ++i) {
            string binary = "";
            int temp = i;
            while (temp > 0) {
                binary = (temp % 2 == 0 ? "0" : "1") + binary;
                temp /= 2;
            }
            if (s.find(binary) == string::npos) {
                return false;
            }
        }
        return true;
    }
};