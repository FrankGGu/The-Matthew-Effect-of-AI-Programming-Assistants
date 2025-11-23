class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        unordered_set<int> unique_nums;
        for (int num : nums) {
            if (num != 0) {
                unique_nums.insert(num);
            }
        }
        return unique_nums.size();
    }
};