public class Solution {

import java.util.*;

public class Solution {
    public int[] fullBloomFlowers(int[] flowers[], int[] people) {
        int n = flowers.length;
        int m = people.length;
        int[] start = new int[n];
        int[] end = new int[n];

        for (int i = 0; i < n; i++) {
            start[i] = flowers[i][0];
            end[i] = flowers[i][1];
        }

        Arrays.sort(start);
        Arrays.sort(end);

        int[] result = new int[m];

        for (int i = 0; i < m; i++) {
            int time = people[i];
            int open = Arrays.binarySearch(start, time);
            if (open < 0) open = ~open;
            int close = Arrays.binarySearch(end, time);
            if (close < 0) close = ~close;
            result[i] = open - close;
        }

        return result;
    }
}
}