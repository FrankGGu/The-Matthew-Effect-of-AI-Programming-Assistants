class Solution {
public:
    int minMoves(vector<int>& nums, int k) {
        vector<int> ones;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                ones.push_back(i);
            }
        }
        int n = ones.size();
        if (k > n) return -1;

        long long sum = 0;
        for (int i = 0; i < k; ++i) {
            sum += ones[i];
        }
        long long ans = sum - (k * (k - 1) / 2);

        for (int i = k; i < n; ++i) {
            sum += ones[i];
            sum -= ones[i - k];
            ans = min(ans, sum - (k * (k - 1) / 2));
        }

        return ans;
    }
};