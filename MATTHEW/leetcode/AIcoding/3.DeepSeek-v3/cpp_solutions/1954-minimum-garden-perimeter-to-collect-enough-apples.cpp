class Solution {
public:
    long long minimumPerimeter(long long neededApples) {
        long long low = 1, high = 1e5;
        long long ans = 0;
        while (low <= high) {
            long long mid = (low + high) / 2;
            long long total = 2 * mid * (mid + 1) * (2 * mid + 1);
            if (total >= neededApples) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans * 8;
    }
};