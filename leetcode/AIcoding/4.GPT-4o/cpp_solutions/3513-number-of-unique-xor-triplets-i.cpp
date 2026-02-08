class Solution {
public:
    int countTriplets(vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        unordered_set<int> uniqueXORs;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    int xorValue = nums[i] ^ nums[j] ^ nums[k];
                    uniqueXORs.insert(xorValue);
                }
            }
        }

        return uniqueXORs.size();
    }
};