class Solution {
public:
    int waysToMakeFair(vector<int>& nums) {
        int n = nums.size();
        vector<int> evenPrefix(n + 1, 0);
        vector<int> oddPrefix(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            evenPrefix[i + 1] = evenPrefix[i];
            oddPrefix[i + 1] = oddPrefix[i];
            if (i % 2 == 0) {
                evenPrefix[i + 1] += nums[i];
            } else {
                oddPrefix[i + 1] += nums[i];
            }
        }

        int res = 0;
        for (int i = 0; i < n; ++i) {
            int evenSum = evenPrefix[i] + (oddPrefix[n] - oddPrefix[i + 1]);
            int oddSum = oddPrefix[i] + (evenPrefix[n] - evenPrefix[i + 1]);
            if (evenSum == oddSum) {
                res++;
            }
        }

        return res;
    }
};