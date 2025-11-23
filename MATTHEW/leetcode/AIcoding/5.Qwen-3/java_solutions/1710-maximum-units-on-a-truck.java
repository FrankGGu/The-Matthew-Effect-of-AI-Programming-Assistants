public class Solution {

import java.util.Arrays;

public class Solution {
    public int maximumUnits(int[][] boxTypes, int truckSize) {
        Arrays.sort(boxTypes, (a, b) -> b[1] - a[1]);
        int totalUnits = 0;
        for (int[] box : boxTypes) {
            int count = Math.min(box[0], truckSize);
            totalUnits += count * box[1];
            truckSize -= count;
            if (truckSize == 0) {
                break;
            }
        }
        return totalUnits;
    }
}
}