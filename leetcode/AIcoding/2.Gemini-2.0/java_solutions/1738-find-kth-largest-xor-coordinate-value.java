class Solution {
    public int kthLargestValue(int[][] matrix, int k) {
        int m = matrix.length;
        int n = matrix[0].length;
        int[][] prefixXor = new int[m][n];
        int[] values = new int[m * n];
        int index = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i == 0 && j == 0) {
                    prefixXor[i][j] = matrix[i][j];
                } else if (i == 0) {
                    prefixXor[i][j] = prefixXor[i][j - 1] ^ matrix[i][j];
                } else if (j == 0) {
                    prefixXor[i][j] = prefixXor[i - 1][j] ^ matrix[i][j];
                } else {
                    prefixXor[i][j] = prefixXor[i - 1][j] ^ prefixXor[i][j - 1] ^ prefixXor[i - 1][j - 1] ^ matrix[i][j];
                }
                values[index++] = prefixXor[i][j];
            }
        }

        return findKthLargest(values, k);
    }

    private int findKthLargest(int[] nums, int k) {
        int n = nums.length;
        return quickSelect(nums, 0, n - 1, n - k);
    }

    private int quickSelect(int[] nums, int left, int right, int k) {
        if (left == right) {
            return nums[left];
        }

        int pivotIndex = partition(nums, left, right);
        if (k == pivotIndex) {
            return nums[k];
        } else if (k < pivotIndex) {
            return quickSelect(nums, left, pivotIndex - 1, k);
        } else {
            return quickSelect(nums, pivotIndex + 1, right, k);
        }
    }

    private int partition(int[] nums, int left, int right) {
        int pivot = nums[right];
        int i = left;
        for (int j = left; j < right; j++) {
            if (nums[j] <= pivot) {
                swap(nums, i, j);
                i++;
            }
        }
        swap(nums, i, right);
        return i;
    }

    private void swap(int[] nums, int i, int j) {
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
}