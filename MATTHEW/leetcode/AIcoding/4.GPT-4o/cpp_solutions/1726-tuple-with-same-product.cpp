class Solution {
public:
    int tupleSameProduct(vector<int>& nums) {
        unordered_map<int, int> productCount;
        int count = 0;

        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j < nums.size(); ++j) {
                int product = nums[i] * nums[j];
                productCount[product]++;
            }
        }

        for (const auto& entry : productCount) {
            int n = entry.second;
            count += n * (n - 1);
        }

        return count;
    }
};