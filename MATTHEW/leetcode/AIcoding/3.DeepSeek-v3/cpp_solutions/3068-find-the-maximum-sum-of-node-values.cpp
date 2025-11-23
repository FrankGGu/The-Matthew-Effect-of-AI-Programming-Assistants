class Solution {
public:
    long long maximumValueSum(vector<int>& nums, int k, vector<vector<int>>& edges) {
        long long total = 0;
        int count = 0;
        int minDiff = INT_MAX;

        for (int num : nums) {
            int xorVal = num ^ k;
            if (xorVal > num) {
                total += xorVal;
                count++;
                minDiff = min(minDiff, xorVal - num);
            } else {
                total += num;
                minDiff = min(minDiff, num - xorVal);
            }
        }

        if (count % 2 == 0) {
            return total;
        } else {
            return total - minDiff;
        }
    }
};