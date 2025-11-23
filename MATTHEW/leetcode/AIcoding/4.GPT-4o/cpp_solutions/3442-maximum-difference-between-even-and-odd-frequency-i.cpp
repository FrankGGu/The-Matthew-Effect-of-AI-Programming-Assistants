class Solution {
public:
    int maximumDifference(vector<int>& nums) {
        int evenCount = 0, oddCount = 0;
        for (int num : nums) {
            if (num % 2 == 0) {
                evenCount++;
            } else {
                oddCount++;
            }
        }
        return evenCount - oddCount;
    }
};