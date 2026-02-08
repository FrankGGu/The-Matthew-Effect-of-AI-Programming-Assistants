public class Solution {

import java.util.*;

public class Solution {
    public int minTimeToCook(int[] time, int[] customer) {
        int n = time.length;
        int m = customer.length;
        int[] freq = new int[n];
        for (int i = 0; i < m; i++) {
            freq[customer[i]]++;
        }
        int[] cookTime = new int[n];
        for (int i = 0; i < n; i++) {
            cookTime[i] = time[i] * freq[i];
        }
        Arrays.sort(cookTime);
        int total = 0;
        for (int i = 0; i < n; i++) {
            total += cookTime[i] * (i + 1);
        }
        return total;
    }
}
}