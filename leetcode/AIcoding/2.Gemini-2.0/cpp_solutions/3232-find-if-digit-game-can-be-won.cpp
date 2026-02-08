class Solution {
public:
    bool digitGame(string n, int k) {
        int len = n.length();
        if (len % 2 != 0) {
            return true;
        }
        if (k == 1) {
            return false;
        }
        int sum1 = 0;
        int sum2 = 0;
        for (int i = 0; i < len; i += 2) {
            if (n[i] < n[i + 1]) {
                return true;
            }
        }
        return false;
    }
};