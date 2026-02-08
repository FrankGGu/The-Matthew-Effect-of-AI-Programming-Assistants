public class Solution {

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

public class Solution {
    public int[][] reconstructQueue(int[][] people) {
        Arrays.sort(people, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                if (b[0] != a[0]) {
                    return b[0] - a[0];
                } else {
                    return a[1] - b[1];
                }
            }
        });

        List<int[]> result = new ArrayList<>();
        for (int[] p : people) {
            result.add(p[1], p);
        }

        return result.toArray(new int[0][0]);
    }
}
}