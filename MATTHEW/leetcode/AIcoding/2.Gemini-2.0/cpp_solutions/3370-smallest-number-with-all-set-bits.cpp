class Solution {
public:
    int smallestNumber(int n) {
        int ans = 0;
        for (int i = 0; i < 32; ++i) {
            if ((n >> i) & 1) {
                ans += (1 << i);
            }
        }
        return ans;
    }
};