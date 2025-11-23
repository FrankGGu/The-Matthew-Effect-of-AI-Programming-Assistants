class Solution {
public:
    int numSub(string s) {
        long long ans = 0;
        int count = 0;
        for (char c : s) {
            if (c == '1') {
                count++;
            } else {
                ans += (long long)count * (count + 1) / 2;
                count = 0;
            }
        }
        ans += (long long)count * (count + 1) / 2;
        return ans % 1000000007;
    }
};