class Solution {
    public int areaOfMaxDiagonal(int[][] dimensions) {
        int maxDiagonalSq = 0;
        int maxArea = 0;

        for (int[] dim : dimensions) {
            int length = dim[0];
            int width = dim[1];

            int currentDiagonalSq = length * length + width * width;
            int currentArea = length * width;

            if (currentDiagonalSq > maxDiagonalSq) {
                maxDiagonalSq = currentDiagonalSq;
                maxArea = currentArea;
            } else if (currentDiagonalSq == maxDiagonalSq) {
                maxArea = Math.max(maxArea, currentArea);
            }
        }

        return maxArea;
    }
}