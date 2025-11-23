public class Solution {

import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int numberOfWeakCharacters(int[][] properties) {
        Arrays.sort(properties, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                if (a[0] == b[0]) {
                    return b[1] - a[1];
                }
                return a[0] - b[0];
            }
        });

        int count = 0;
        int maxDef = 0;

        for (int[] p : properties) {
            if (p[1] < maxDef) {
                count++;
            } else {
                maxDef = p[1];
            }
        }

        return count;
    }
}
}