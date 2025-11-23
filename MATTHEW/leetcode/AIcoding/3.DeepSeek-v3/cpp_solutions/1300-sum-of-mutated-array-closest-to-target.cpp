class Solution {
public:
    int findBestValue(vector<int>& arr, int target) {
        int left = 0;
        int right = *max_element(arr.begin(), arr.end());
        int best_diff = INT_MAX;
        int best_value = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int sum = 0;
            for (int num : arr) {
                sum += num > mid ? mid : num;
            }

            int current_diff = abs(sum - target);
            if (current_diff < best_diff || (current_diff == best_diff && mid < best_value)) {
                best_diff = current_diff;
                best_value = mid;
            }

            if (sum < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return best_value;
    }
};