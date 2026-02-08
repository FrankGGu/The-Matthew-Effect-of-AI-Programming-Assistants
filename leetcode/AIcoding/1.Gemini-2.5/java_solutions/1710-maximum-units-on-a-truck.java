import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int maximumUnits(int[][] boxTypes, int truckSize) {
        Arrays.sort(boxTypes, (a, b) -> b[1] - a[1]);

        int totalUnits = 0;
        int remainingTruckSize = truckSize;

        for (int[] boxType : boxTypes) {
            int numberOfBoxes = boxType[0];
            int unitsPerBox = boxType[1];

            if (remainingTruckSize == 0) {
                break;
            }

            int boxesToLoad = Math.min(numberOfBoxes, remainingTruckSize);

            totalUnits += boxesToLoad * unitsPerBox;
            remainingTruckSize -= boxesToLoad;
        }

        return totalUnits;
    }
}