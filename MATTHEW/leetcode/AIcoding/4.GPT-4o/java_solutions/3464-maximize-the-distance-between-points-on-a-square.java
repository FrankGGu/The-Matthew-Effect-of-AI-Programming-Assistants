class Solution {
    public int maxDistance(int[][] points) {
        int maxDist = 0;
        for (int[] point1 : points) {
            for (int[] point2 : points) {
                maxDist = Math.max(maxDist, Math.abs(point1[0] - point2[0]) + Math.abs(point1[1] - point2[1]));
            }
        }
        return maxDist;
    }
}