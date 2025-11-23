public class Solution {
    public int maxDistance(int[][] arrays) {
        int min = arrays[0][0], max = arrays[0][0], maxDistance = 0;

        for (int i = 1; i < arrays.length; i++) {
            maxDistance = Math.max(maxDistance, Math.abs(arrays[i][0] - max));
            maxDistance = Math.max(maxDistance, Math.abs(arrays[i][arrays[i].length - 1] - min));
            min = Math.min(min, arrays[i][0]);
            max = Math.max(max, arrays[i][arrays[i].length - 1]);
        }

        return maxDistance;
    }
}