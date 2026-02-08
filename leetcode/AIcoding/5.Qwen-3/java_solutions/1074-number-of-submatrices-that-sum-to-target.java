public class Solution {
    public int numSubmatrixSumTarget(int[][] matrix, int target) {
        int rows = matrix.length;
        int cols = matrix[0].length;
        int result = 0;

        for (int left = 0; left < cols; left++) {
            int[] temp = new int[rows];
            for (int right = left; right < cols; right++) {
                for (int i = 0; i < rows; i++) {
                    temp[i] += matrix[i][right];
                }

                result += subarraySum(temp, target);
            }
        }

        return result;
    }

    private int subarraySum(int[] nums, int k) {
        int count = 0;
        int prefixSum = 0;
        java.util.HashMap<Integer, Integer> sumCounts = new java.util.HashMap<>();
        sumCounts.put(0, 1);

        for (int num : nums) {
            prefixSum += num;
            if (sumCounts.containsKey(prefixSum - k)) {
                count += sumCounts.get(prefixSum - k);
            }
            sumCounts.put(prefixSum, sumCounts.getOrDefault(prefixSum, 0) + 1);
        }

        return count;
    }
}