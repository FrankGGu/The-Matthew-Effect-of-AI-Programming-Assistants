class Solution {
    public int securityCheck(int[] security) {
        int n = security.length;
        int left = 0, right = n - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (security[mid] == 0) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}