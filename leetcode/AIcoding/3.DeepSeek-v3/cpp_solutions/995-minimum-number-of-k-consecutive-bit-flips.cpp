class Solution {
public:
    int minKBitFlips(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> flip(n + 1, 0);
        int res = 0, flipCount = 0;

        for (int i = 0; i < n; ++i) {
            flipCount ^= flip[i];
            if ((nums[i] ^ flipCount) == 0) {
                if (i + k > n) {
                    return -1;
                }
                res++;
                flipCount ^= 1;
                flip[i + k] ^= 1;
            }
        }

        return res;
    }
};