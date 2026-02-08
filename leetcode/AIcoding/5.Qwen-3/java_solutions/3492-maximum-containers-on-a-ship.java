public class Solution {

import java.util.*;

public class Solution {
    public int maximumContainers(int[] weights, int maxWeight) {
        Arrays.sort(weights);
        int left = 0;
        int right = weights.length - 1;
        int count = 0;

        while (left <= right) {
            if (weights[left] + weights[right] <= maxWeight) {
                left++;
            }
            right--;
            count++;
        }

        return count;
    }
}
}