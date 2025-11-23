class Solution {
public:
    int countTriplets(vector<int>& nums) {
        int n = nums.size();
        unordered_set<int> uniqueXor;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    uniqueXor.insert(nums[i] ^ nums[j] ^ nums[k]);
                }
            }
        }
        return uniqueXor.size();
    }
};