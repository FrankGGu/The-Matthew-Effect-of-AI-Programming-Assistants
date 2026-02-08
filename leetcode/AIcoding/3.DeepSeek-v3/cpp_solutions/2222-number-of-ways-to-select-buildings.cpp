class Solution {
public:
    long long numberOfWays(string s) {
        long long total0 = 0, total1 = 0;
        for (char c : s) {
            if (c == '0') total0++;
            else total1++;
        }

        long long res = 0;
        long long current0 = 0, current1 = 0;
        for (char c : s) {
            if (c == '0') {
                res += current1 * (total1 - current1);
                current0++;
            } else {
                res += current0 * (total0 - current0);
                current1++;
            }
        }
        return res;
    }
};