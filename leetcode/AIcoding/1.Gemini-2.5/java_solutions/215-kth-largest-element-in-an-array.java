import java.util.Random;

class Solution {

    private Random random = new Random();

    public int findKthLargest(int[] nums, int k) {
        int n = nums.length;
        int targetIndex = n - k;

        int left = 0;
        int right = n - 1;

        while (left <= right) {
            int pivotIndex = randomizedPartition(nums, left, right);

            if (pivotIndex == targetIndex) {
                return nums[pivotIndex];
            } else if (pivotIndex < targetIndex) {
                left = pivotIndex + 1;
            } else {
                right = pivotIndex - 1;
            }
        }
        return -1; 
    }

    private int randomizedPartition(int[] nums, int left, int right) {
        int pivotIdx = left + random.nextInt(right - left + 1);

        swap(nums, pivotIdx, right);

        return partition(nums, left, right);
    }

    private int partition(int[] nums, int left, int right) {
        int pivotValue = nums[right];
        int storeIndex = left; 

        for (int i = left; i < right; i++) {
            if (nums[i] < pivotValue) {
                swap(nums, storeIndex, i);
                storeIndex++;
            }
        }
        swap(nums, storeIndex, right);
        return storeIndex;
    }

    private void swap(int[] nums, int i, int j) {
        if (i == j) return;
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
}