import java.util.Arrays;

class Solution {
    public int maximumUnits(int[][] boxTypes, int truckSize) {
        Arrays.sort(boxTypes, (a, b) -> b[1] - a[1]);
        int totalUnits = 0;
        for (int[] boxType : boxTypes) {
            int numberOfBoxes = boxType[0];
            int unitsPerBox = boxType[1];
            if (truckSize >= numberOfBoxes) {
                totalUnits += numberOfBoxes * unitsPerBox;
                truckSize -= numberOfBoxes;
            } else {
                totalUnits += truckSize * unitsPerBox;
                break;
            }
        }
        return totalUnits;
    }
}