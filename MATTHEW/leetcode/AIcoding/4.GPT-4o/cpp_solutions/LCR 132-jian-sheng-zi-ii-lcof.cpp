class Solution {
public:
    int cut(int m, int k) {
        long long left = 1, right = m;
        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long total = 0;
            long long height = mid;
            for (int i = 1; i <= k && height > 0; ++i) {
                total += height;
                height /= 2;
            }
            if (total < m) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};