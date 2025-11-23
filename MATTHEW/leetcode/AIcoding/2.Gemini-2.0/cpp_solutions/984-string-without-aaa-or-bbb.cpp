#include <string>

using namespace std;

class Solution {
public:
    string strWithout3a3b(int a, int b) {
        string res = "";
        while (a > 0 || b > 0) {
            if (a > b) {
                if (res.length() >= 1 && res.back() == 'a') {
                    if (b > 0) {
                        res += 'b';
                        b--;
                    } else {
                        break;
                    }
                } else {
                    res += 'a';
                    a--;
                }
            } else if (b > a) {
                if (res.length() >= 1 && res.back() == 'b') {
                    if (a > 0) {
                        res += 'a';
                        a--;
                    } else {
                        break;
                    }
                } else {
                    res += 'b';
                    b--;
                }
            } else {
                if (res.length() >= 1 && res.back() == 'a') {
                    res += 'b';
                    b--;
                } else {
                    res += 'a';
                    a--;
                }
            }
        }
        return res;
    }
};