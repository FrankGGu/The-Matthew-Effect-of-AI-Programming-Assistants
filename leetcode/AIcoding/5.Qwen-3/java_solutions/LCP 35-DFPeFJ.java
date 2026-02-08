public class Solution {

import java.util.*;

public class Solution {
    public int electricCarTour(int[] stations, int n, int k) {
        int total = 0;
        int current = 0;
        int start = 0;
        for (int i = 0; i < n; i++) {
            total += stations[i];
            current += stations[i];
            if (current < 0) {
                start = i + 1;
                current = 0;
            }
        }
        if (total < k) {
            return -1;
        }
        return start;
    }
}
}