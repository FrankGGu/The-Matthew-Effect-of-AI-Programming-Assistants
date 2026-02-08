class Solution {
public:
    int maximizeSum(vector<int>& nums, int remove) {
        long long totalSum = 0, removedSum = 0;
        for (int num : nums) {
            totalSum += num;
        }
        for (int num : nums) {
            if (num == remove) {
                removedSum += num;
            }
        }
        return totalSum - removedSum;
    }
};