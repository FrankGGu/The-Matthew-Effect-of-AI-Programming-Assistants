public class Solution {

import java.util.*;

public class Solution {
    public int maxConsecutive(int n, int[] specialties) {
        Arrays.sort(specialties);
        int max = 0;
        int prev = 0;
        for (int special : specialties) {
            max = Math.max(max, special - prev - 1);
            prev = special;
        }
        max = Math.max(max, n - prev);
        return max;
    }
}
}