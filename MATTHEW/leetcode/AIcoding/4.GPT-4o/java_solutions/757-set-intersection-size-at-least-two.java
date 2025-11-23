import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int intersectionSizeTwo(int[][] intervals) {
        Arrays.sort(intervals, Comparator.comparingInt(a -> a[1]));
        int[] last = new int[2];
        int count = 0;

        for (int[] interval : intervals) {
            if (last[1] < interval[0]) {
                count += 2;
                last[0] = interval[1] - 1;
                last[1] = interval[1];
            } else if (last[0] < interval[0]) {
                count += 1;
                last[0] = last[1];
                last[1] = interval[1];
            }
        }
        return count;
    }
}