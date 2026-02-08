class Solution {
public:
    int findBestValue(vector<int>& arr, int target) {
        int left = 0, right = *max_element(arr.begin(), arr.end()), bestValue = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            long long sum = 0;
            for (int num : arr) {
                sum += min(num, mid);
            }
            if (sum < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
                bestValue = mid;
            }
        }

        long long sum1 = 0, sum2 = 0;
        for (int num : arr) {
            sum1 += min(num, bestValue);
            sum2 += min(num, bestValue + 1);
        }

        return (abs(sum1 - target) <= abs(sum2 - target)) ? bestValue : bestValue + 1;
    }
};