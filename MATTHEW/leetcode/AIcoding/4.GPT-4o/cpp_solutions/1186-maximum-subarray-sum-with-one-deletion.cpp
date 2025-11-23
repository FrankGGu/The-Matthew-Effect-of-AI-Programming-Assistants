class Solution {
public:
    int maximumSum(vector<int>& arr) {
        int n = arr.size();
        int maxSum = arr[0], maxSumWithDel = 0, currentMax = arr[0];

        for (int i = 1; i < n; i++) {
            currentMax = max(arr[i], currentMax + arr[i]);
            maxSum = max(maxSum, currentMax);
            maxSumWithDel = max(maxSumWithDel + arr[i], maxSum);
            maxSumWithDel = max(maxSumWithDel, currentMax);
        }

        return max(maxSum, maxSumWithDel);
    }
};