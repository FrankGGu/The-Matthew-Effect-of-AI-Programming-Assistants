class Solution {
public:
    int sumOddLengthSubarrays(vector<int>& arr) {
        int totalSum = 0;
        int n = arr.size();

        for (int i = 0; i < n; ++i) {
            int oddCount = ((i + 1) * (n - i) + 1) / 2;
            totalSum += arr[i] * oddCount;
        }

        return totalSum;
    }
};