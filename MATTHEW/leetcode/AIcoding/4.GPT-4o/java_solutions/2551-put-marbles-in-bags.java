import java.util.*;

class Solution {
    public int putMarbles(int[] weights, int k) {
        int n = weights.length;
        int[] pairs = new int[n - 1];
        for (int i = 0; i < n - 1; i++) {
            pairs[i] = weights[i] + weights[i + 1];
        }
        Arrays.sort(pairs);
        int min = 0, max = 0;
        for (int i = 0; i < k - 1; i++) {
            min += pairs[i];
        }
        for (int i = n - 2; i >= n - k + 1; i--) {
            max += pairs[i];
        }
        return max - min;
    }
}