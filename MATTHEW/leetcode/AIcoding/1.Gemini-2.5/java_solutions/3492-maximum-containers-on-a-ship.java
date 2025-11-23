import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int maximumUnits(int[][] boxTypes, int truckSize) {
        Arrays.sort(boxTypes, (a, b) -> b[1] - a[1]);

        int totalUnits = 0;
        for (int[] boxType : boxTypes) {
            int numberOfBoxes = boxType[0];
            int unitsPerBox = boxType[1];

            if (truckSize <= 0) {
                break;
            }

            int boxesToTake = Math.min(numberOfBoxes, truckSize);
            totalUnits += boxesToTake * unitsPerBox;
            truckSize -= boxesToTake;
        }

        return totalUnits;
    }
}