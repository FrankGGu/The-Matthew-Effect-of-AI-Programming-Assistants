class Solution {
public:
    int numOfSubarrays(std::vector<int>& arr, int k, int threshold) {
        int n = arr.size();
        if (n < k) {
            return 0;
        }

        long long current_sum = 0;
        int count = 0;
        long long target_sum = (long long)threshold * k;

        for (int i = 0; i < k; ++i) {
            current_sum += arr[i];
        }

        if (current_sum >= target_sum) {
            count++;
        }

        for (int i = k; i < n; ++i) {
            current_sum += arr[i] - arr[i - k];
            if (current_sum >= target_sum) {
                count++;
            }
        }

        return count;
    }
};