import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int fillCups(int[] amount) {
        int maxVal = 0;
        long sumVal = 0;
        for (int x : amount) {
            maxVal = Math.max(maxVal, x);
            sumVal += x;
        }

        if (maxVal > sumVal - maxVal) {
            return maxVal;
        } else {
            return (int) ((sumVal + 1) / 2);
        }
    }
}