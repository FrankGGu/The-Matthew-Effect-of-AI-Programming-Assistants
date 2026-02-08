class Solution {
    public int minimizedMaximum(int n, int[] quantities) {
        int left = 1, right = (int) 1e9;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canDistribute(quantities, mid, n)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canDistribute(int[] quantities, int max, int n) {
        int stores = 0;
        for (int quantity : quantities) {
            stores += (quantity + max - 1) / max;
            if (stores > n) {
                return false;
            }
        }
        return true;
    }
}