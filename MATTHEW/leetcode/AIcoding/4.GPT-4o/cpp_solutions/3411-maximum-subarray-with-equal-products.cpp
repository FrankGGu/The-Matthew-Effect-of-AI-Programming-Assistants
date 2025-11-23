class Solution {
public:
    int maxEqualProduct(vector<int>& nums) {
        unordered_map<int, int> productCount;
        int maxLength = 0;

        for (int i = 0; i < nums.size(); ++i) {
            int product = 1;
            for (int j = i; j < nums.size(); ++j) {
                product *= nums[j];
                productCount[product]++;
                if (productCount[product] > maxLength) {
                    maxLength = productCount[product];
                }
            }
            productCount.clear();
        }

        return maxLength;
    }
};