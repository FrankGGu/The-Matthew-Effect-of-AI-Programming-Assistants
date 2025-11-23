class Solution {
    public int movesToMakeZigzag(int[] nums) {
        int n = nums.length;
        if (n == 1) return 0;
        int evenMoves = 0;
        int oddMoves = 0;

        int[] a = nums.clone();
        int[] b = nums.clone();

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                int left = (i > 0) ? a[i - 1] : Integer.MAX_VALUE;
                int right = (i < n - 1) ? a[i + 1] : Integer.MAX_VALUE;
                if (a[i] >= Math.min(left, right)) {
                    evenMoves += a[i] - Math.min(left, right) + 1;
                    a[i] = Math.min(left, right) - 1;
                }
            } else {
                int left = (i > 0) ? b[i - 1] : Integer.MAX_VALUE;
                int right = (i < n - 1) ? b[i + 1] : Integer.MAX_VALUE;
                if (b[i] >= Math.min(left, right)) {
                    oddMoves += b[i] - Math.min(left, right) + 1;
                    b[i] = Math.min(left, right) - 1;
                }
            }
        }

        return Math.min(evenMoves, oddMoves);
    }
}