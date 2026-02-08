class Solution {
public:
    string strWithout3a3b(int a, int b) {
        string res;
        while (a > 0 || b > 0) {
            bool writeA = false;
            int n = res.size();
            if (n >= 2 && res[n-1] == res[n-2]) {
                if (res[n-1] == 'b') {
                    writeA = true;
                }
            } else {
                if (a >= b) {
                    writeA = true;
                }
            }
            if (writeA) {
                res += 'a';
                a--;
            } else {
                res += 'b';
                b--;
            }
        }
        return res;
    }
};