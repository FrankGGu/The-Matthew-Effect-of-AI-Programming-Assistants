class Solution {
public:
    int numSub(string s) {
        long long res = 0;
        long long count = 0;
        for (char c : s) {
            if (c == '1') {
                count++;
                res += count;
            } else {
                count = 0;
            }
        }
        return res % 1000000007;
    }
};