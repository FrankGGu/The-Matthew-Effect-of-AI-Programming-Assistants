class Solution {
    public int countSubmatricesWithSumLessThanK(int[][] matrix, int k) {
        int rows = matrix.length, cols = matrix[0].length;
        int count = 0;

        for (int left = 0; left < cols; left++) {
            int[] sum = new int[rows];
            for (int right = left; right < cols; right++) {
                for (int i = 0; i < rows; i++) {
                    sum[i] += matrix[i][right];
                }
                count += countSubarraysWithSumLessThanK(sum, k);
            }
        }
        return count;
    }

    private int countSubarraysWithSumLessThanK(int[] sum, int k) {
        int count = 0;
        int currentSum = 0;
        TreeMap<Integer, Integer> prefixSumCount = new TreeMap<>();
        prefixSumCount.put(0, 1);

        for (int s : sum) {
            currentSum += s;
            count += prefixSumCount.headMap(currentSum - k).size();
            prefixSumCount.put(currentSum, prefixSumCount.getOrDefault(currentSum, 0) + 1);
        }
        return count;
    }
}