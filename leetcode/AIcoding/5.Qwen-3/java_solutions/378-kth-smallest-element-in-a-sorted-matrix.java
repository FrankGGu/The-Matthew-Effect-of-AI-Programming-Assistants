public class Solution {
    public int kthSmallest(int[][] matrix, int k) {
        int n = matrix.length;
        int left = 0;
        int right = n * n - 1;

        while (left < right) {
            int pivotIndex = partition(matrix, left, right);
            if (pivotIndex == k - 1) {
                break;
            } else if (pivotIndex < k - 1) {
                left = pivotIndex + 1;
            } else {
                right = pivotIndex - 1;
            }
        }

        return matrix[left][0];
    }

    private int partition(int[][] matrix, int left, int right) {
        int[] pivot = matrix[right];
        int i = left;

        for (int j = left; j < right; j++) {
            if (matrix[j][0] <= pivot[0]) {
                swap(matrix, i, j);
                i++;
            }
        }

        swap(matrix, i, right);
        return i;
    }

    private void swap(int[][] matrix, int i, int j) {
        int[] temp = matrix[i];
        matrix[i] = matrix[j];
        matrix[j] = temp;
    }
}