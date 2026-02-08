import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int intersectionSizeTwo(int[][] intervals) {
        Arrays.sort(intervals, new Comparator<int[]>() {
            @Override
            public int compare(int[] i1, int[] i2) {
                if (i1[1] != i2[1]) {
                    return i1[1] - i2[1];
                }
                return i2[0] - i1[0];
            }
        });

        int count = 0;
        int last1 = -1;
        int last2 = -1;

        for (int[] interval : intervals) {
            int a = interval[0];
            int b = interval[1];

            if (a <= last1) {
                continue;
            } else if (a <= last2) {
                count++;
                last1 = last2;
                last2 = b;
            } else {
                count += 2;
                last1 = b - 1;
                last2 = b;
            }
        }

        return count;
    }
}