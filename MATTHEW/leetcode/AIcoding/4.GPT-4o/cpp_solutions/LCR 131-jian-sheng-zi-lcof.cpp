class Solution {
public:
    int cut(int n) {
        int res = 0;
        while (n > 0) {
            res += n;
            n /= 2;
        }
        return res;
    }
};