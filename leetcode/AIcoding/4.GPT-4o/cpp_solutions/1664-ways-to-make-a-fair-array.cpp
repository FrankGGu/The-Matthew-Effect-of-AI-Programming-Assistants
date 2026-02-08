class Solution {
public:
    int waysToMakeFair(vector<int>& nums) {
        int n = nums.size();
        vector<int> prefixEven(n + 1, 0), prefixOdd(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefixEven[i + 1] = prefixEven[i] + (i % 2 == 0 ? nums[i] : 0);
            prefixOdd[i + 1] = prefixOdd[i] + (i % 2 == 1 ? nums[i] : 0);
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            int evenSum = prefixEven[i] + (prefixOdd[n] - prefixOdd[i + 1]);
            int oddSum = prefixOdd[i] + (prefixEven[n] - prefixEven[i + 1]);
            if (evenSum == oddSum) {
                count++;
            }
        }

        return count;
    }
};