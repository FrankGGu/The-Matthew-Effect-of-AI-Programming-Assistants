class Solution {
public:
    int maxStrength(vector<int>& nums, int k) {
        int n = nums.size();
        sort(nums.begin(), nums.end(), greater<int>());
        long long product = 1;
        int count = 0;

        for (int i = 0; i < n && count < k; ++i) {
            if (nums[i] > 0 || (count < k - 1 && nums[i] < 0)) {
                product *= nums[i];
                count++;
            }
        }

        if (count < k) return 0;

        return product;
    }
};