import java.util.Arrays;

public class Solution {
    public int maxContainers(int[] containers, int[] weights, int limit) {
        Arrays.sort(containers);
        Arrays.sort(weights);

        int i = 0, j = 0, count = 0;
        while (i < containers.length && j < weights.length) {
            if (containers[i] + weights[j] <= limit) {
                count++;
                i++;
                j++;
            } else {
                j++;
            }
        }
        return count;
    }
}