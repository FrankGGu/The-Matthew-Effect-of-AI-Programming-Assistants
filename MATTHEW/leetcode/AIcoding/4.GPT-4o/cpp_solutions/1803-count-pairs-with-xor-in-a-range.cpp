class Solution {
public:
    int countPairs(vector<int>& nums, int low, int high) {
        return countPairsWithXOR(nums, high) - countPairsWithXOR(nums, low - 1);
    }

    int countPairsWithXOR(vector<int>& nums, int target) {
        int count = 0;
        unordered_map<int, int> freq;
        for (int num : nums) {
            count += freq[target ^ num];
            freq[num]++;
        }
        return count;
    }
};