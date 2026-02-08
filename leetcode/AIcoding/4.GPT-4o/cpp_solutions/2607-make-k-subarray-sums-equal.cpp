class Solution {
public:
    long long makeKSubarraySumsEqual(vector<int>& arr, int k) {
        long long totalSum = accumulate(arr.begin(), arr.end(), 0LL);
        long long targetSum = totalSum / k;
        long long excess = 0;

        for (int i = 0; i < k; i++) {
            long long currentSum = 0;
            for (int j = i; j < arr.size(); j += k) {
                currentSum += arr[j];
            }
            excess += abs(currentSum - targetSum);
        }

        return excess / 2;
    }
};