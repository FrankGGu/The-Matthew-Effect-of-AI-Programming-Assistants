class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        unordered_set<int> uniqueNums;
        for (int num : nums) {
            if (num != 0) {
                uniqueNums.insert(num);
            }
        }
        return uniqueNums.size();
    }
};