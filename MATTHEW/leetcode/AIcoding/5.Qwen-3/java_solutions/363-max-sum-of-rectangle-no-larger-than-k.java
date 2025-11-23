public class Solution {

import java.util.*;

public class Solution {
    public int maxSumSubmatrix(int[][] matrix, int k) {
        int rows = matrix.length;
        int cols = matrix[0].length;
        int maxSum = Integer.MIN_VALUE;

        for (int left = 0; left < cols; left++) {
            int[] temp = new int[rows];
            for (int right = left; right < cols; right++) {
                for (int i = 0; i < rows; i++) {
                    temp[i] += matrix[i][right];
                }

                TreeSet<Integer> sorted = new TreeSet<>();
                sorted.add(0);
                int currSum = 0;
                for (int num : temp) {
                    currSum += num;
                    Integer target = currSum - k;
                    if (sorted.contains(target)) {
                        maxSum = Math.max(maxSum, currSum - target);
                    }
                    sorted.add(currSum);
                }
            }
        }

        return maxSum;
    }
}
}