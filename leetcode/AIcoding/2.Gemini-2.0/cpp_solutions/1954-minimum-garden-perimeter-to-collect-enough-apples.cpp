class Solution {
public:
    long long minimumPerimeter(long long neededApples) {
        long long left = 1, right = 100000;
        long long ans = right;
        while (left <= right) {
            long long mid = left + (right - left) / 2;
            long long apples = 2 * mid * (mid + 1) * (2 * mid + 1);
            if (apples >= neededApples) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return 8 * ans;
    }
};