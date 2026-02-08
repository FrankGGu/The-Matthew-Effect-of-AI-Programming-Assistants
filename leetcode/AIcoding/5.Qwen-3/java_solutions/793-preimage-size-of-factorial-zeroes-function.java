public class Solution {
    public int trailingZeroes(int n) {
        int count = 0;
        while (n > 0) {
            n /= 5;
            count += n;
        }
        return count;
    }

    public int preimageSizeFZF(int k) {
        int left = 0, right = 5 * k;
        while (left < right) {
            int mid = left + (right - left) / 2;
            int zeros = trailingZeroes(mid);
            if (zeros < k) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return trailingZeroes(left) == k ? 0 : 5;
    }
}