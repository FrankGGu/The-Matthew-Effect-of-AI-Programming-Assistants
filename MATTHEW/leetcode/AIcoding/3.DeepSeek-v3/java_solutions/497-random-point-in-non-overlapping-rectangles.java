class Solution {
    private int[][] rects;
    private int[] prefixSums;
    private Random random;

    public Solution(int[][] rects) {
        this.rects = rects;
        this.prefixSums = new int[rects.length];
        this.random = new Random();
        for (int i = 0; i < rects.length; i++) {
            int[] rect = rects[i];
            int area = (rect[2] - rect[0] + 1) * (rect[3] - rect[1] + 1);
            prefixSums[i] = (i == 0) ? area : prefixSums[i - 1] + area;
        }
    }

    public int[] pick() {
        int total = prefixSums[prefixSums.length - 1];
        int target = random.nextInt(total) + 1;
        int left = 0, right = prefixSums.length - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (prefixSums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        int[] rect = rects[left];
        int x = rect[0] + random.nextInt(rect[2] - rect[0] + 1);
        int y = rect[1] + random.nextInt(rect[3] - rect[1] + 1);
        return new int[]{x, y};
    }
}