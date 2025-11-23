import java.util.Arrays;

public class Solution {
    public long minimumBoxes(int n) {
        int k = 0;
        long totalBoxes = 0;
        while (totalBoxes + (k + 1) * (k + 2) / 2 <= n) {
            k++;
            totalBoxes += k;
        }
        long remaining = n - (totalBoxes - k);
        return totalBoxes + Math.min(k, remaining);
    }
}