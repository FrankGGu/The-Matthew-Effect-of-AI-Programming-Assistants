class Solution {
public:
    int minimizedMaximum(int n, vector<int>& quantities) {
        int left = 1, right = *max_element(quantities.begin(), quantities.end());
        while (left < right) {
            int mid = left + (right - left) / 2;
            int sum = 0;
            for (int q : quantities) {
                sum += (q + mid - 1) / mid;
            }
            if (sum > n) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};