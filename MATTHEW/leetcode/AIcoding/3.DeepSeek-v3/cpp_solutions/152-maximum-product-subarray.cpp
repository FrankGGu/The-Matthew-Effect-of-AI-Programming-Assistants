class Solution {
public:
    int maxProduct(vector<int>& nums) {
        if (nums.empty()) return 0;
        int maxProd = nums[0];
        int minProd = nums[0];
        int result = nums[0];

        for (int i = 1; i < nums.size(); ++i) {
            int temp = maxProd;
            maxProd = max({nums[i], maxProd * nums[i], minProd * nums[i]});
            minProd = min({nums[i], temp * nums[i], minProd * nums[i]});
            result = max(result, maxProd);
        }

        return result;
    }
};