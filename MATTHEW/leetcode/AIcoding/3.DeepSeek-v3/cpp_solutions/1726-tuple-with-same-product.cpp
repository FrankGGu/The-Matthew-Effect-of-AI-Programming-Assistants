class Solution {
public:
    int tupleSameProduct(vector<int>& nums) {
        unordered_map<int, int> productCount;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int product = nums[i] * nums[j];
                productCount[product]++;
            }
        }
        int result = 0;
        for (auto& [product, count] : productCount) {
            if (count >= 2) {
                result += count * (count - 1) / 2 * 8;
            }
        }
        return result;
    }
};