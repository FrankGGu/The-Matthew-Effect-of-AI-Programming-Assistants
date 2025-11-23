class Solution {
public:
    int countSubsequencesWithUniqueMode(vector<int>& nums) {
        int n = nums.size();
        int MOD = 1e9 + 7;
        long long res = 0;

        for (int i = 0; i < n; ++i) {
            vector<int> freq(101, 0);
            int max_freq = 0;
            int mode = -1;
            bool unique = true;

            for (int j = i; j < n; ++j) {
                int num = nums[j];
                freq[num]++;

                if (freq[num] > max_freq) {
                    max_freq = freq[num];
                    mode = num;
                    unique = true;
                } else if (freq[num] == max_freq) {
                    unique = false;
                }

                if (unique) {
                    res = (res + 1) % MOD;
                }
            }
        }

        return res;
    }
};