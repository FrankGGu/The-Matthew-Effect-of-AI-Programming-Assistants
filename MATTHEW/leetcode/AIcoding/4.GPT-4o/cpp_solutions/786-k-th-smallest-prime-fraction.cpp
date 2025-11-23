class Solution {
public:
    vector<int> kthSmallestPrimeFraction(vector<int>& arr, int k) {
        int n = arr.size();
        double left = 0, right = 1;
        vector<int> result;

        while (left < right) {
            double mid = (left + right) / 2;
            int count = 0;
            int max_numerator = 0, max_denominator = 1;

            for (int i = 0, j = 1; i < n; ++i) {
                while (j < n && arr[i] > mid * arr[j]) {
                    ++j;
                }
                count += j;
                if (j > 0 && arr[i] * max_denominator > max_numerator * arr[j - 1]) {
                    max_numerator = arr[i];
                    max_denominator = arr[j - 1];
                }
            }

            if (count > k) {
                right = mid;
            } else {
                left = mid;
                result = {max_numerator, max_denominator};
            }
        }

        return result;
    }
};