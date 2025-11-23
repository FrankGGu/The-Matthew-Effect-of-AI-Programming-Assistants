class Solution {
    public int maxArea(int h, int w, int[] horizontal, int[] vertical) {
        Arrays.sort(horizontal);
        Arrays.sort(vertical);

        int maxH = horizontal[0];
        int maxW = vertical[0];

        for (int i = 1; i < horizontal.length; i++) {
            maxH = Math.max(maxH, horizontal[i] - horizontal[i - 1]);
        }
        maxH = Math.max(maxH, h - horizontal[horizontal.length - 1]);

        for (int i = 1; i < vertical.length; i++) {
            maxW = Math.max(maxW, vertical[i] - vertical[i - 1]);
        }
        maxW = Math.max(maxW, w - vertical[vertical.length - 1]);

        return maxH * maxW;
    }
}