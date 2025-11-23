class Solution {
public:
    vector<int> kthSmallestPrimeFraction(vector<int>& arr, int k) {
        int n = arr.size();
        double left = 0.0, right = 1.0;
        vector<int> res;

        while (left <= right) {
            double mid = (left + right) / 2;
            int count = 0;
            int numerator = 0, denominator = 1;
            int j = 1;

            for (int i = 0; i < n - 1; ++i) {
                while (j < n && arr[i] > mid * arr[j]) {
                    ++j;
                }
                count += n - j;
                if (j < n && numerator * arr[j] < denominator * arr[i]) {
                    numerator = arr[i];
                    denominator = arr[j];
                }
            }

            if (count == k) {
                res = {numerator, denominator};
                break;
            } else if (count < k) {
                left = mid;
            } else {
                right = mid;
            }
        }

        return res;
    }
};