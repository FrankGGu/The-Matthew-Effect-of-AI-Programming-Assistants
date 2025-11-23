import java.util.Arrays;

class Solution {
    public int maximizeHappiness(int[] happiness, int k) {
        Arrays.sort(happiness);
        int n = happiness.length;
        int sum = 0;
        for (int i = n - 1; i >= n - k; i--) {
            sum += happiness[i];
        }
        return sum;
    }
}