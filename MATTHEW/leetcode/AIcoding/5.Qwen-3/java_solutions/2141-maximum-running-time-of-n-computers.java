public class Solution {

import java.util.Arrays;

public class Solution {
    public long maxRunTime(int n, int[] batteries) {
        Arrays.sort(batteries);
        long sum = 0;
        for (int b : batteries) {
            sum += b;
        }
        int i = batteries.length - 1;
        while (i >= 0 && sum / n < batteries[i]) {
            sum -= batteries[i];
            n--;
            i--;
        }
        return sum / n;
    }
}
}