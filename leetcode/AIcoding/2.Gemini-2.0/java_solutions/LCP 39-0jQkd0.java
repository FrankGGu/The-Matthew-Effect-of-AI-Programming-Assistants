class Solution {
    public int minimumTime(int[] height, int width, int bricks) {
        int n = height.length;
        int low = 0, high = 100000;
        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            long count = 0;
            for (int h : height) {
                count += Math.max(0, (long)Math.ceil((double) (h - mid) / bricks));
            }

            if (count <= width) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }
}