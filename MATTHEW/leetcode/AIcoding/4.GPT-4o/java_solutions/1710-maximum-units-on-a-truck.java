import java.util.Arrays;

class Solution {
    public int maximumUnits(int[][] boxTypes, int truckSize) {
        Arrays.sort(boxTypes, (a, b) -> b[1] - a[1]);
        int units = 0;

        for (int[] box : boxTypes) {
            if (truckSize <= 0) break;
            int count = Math.min(box[0], truckSize);
            units += count * box[1];
            truckSize -= count;
        }

        return units;
    }
}