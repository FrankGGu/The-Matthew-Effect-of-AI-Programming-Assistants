public class Solution {

import java.util.*;

public class Solution {
    public int maximumElementSum(int[] nums) {
        int n = nums.length;
        boolean[] visited = new boolean[n];
        int sum = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int current = i;
                int currentSum = 0;
                while (!visited[current]) {
                    visited[current] = true;
                    currentSum += nums[current];
                    current = (current + 1) % n;
                }
                sum += currentSum;
            }
        }

        return sum;
    }
}
}