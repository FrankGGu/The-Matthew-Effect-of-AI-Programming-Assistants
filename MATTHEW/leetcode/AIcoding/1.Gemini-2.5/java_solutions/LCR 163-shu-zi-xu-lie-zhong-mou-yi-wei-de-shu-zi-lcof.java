import java.util.Random;

class Solution {

    private Random random = new Random();

    public int findKthLargest(int[] nums, int k) {
        int n = nums.length;
        // The k-th largest element is at index (n - k) if the array were sorted in ascending order (0-indexed).
        int targetIndex = n - k; 
        return quickSelect(nums, 0, n - 1, targetIndex);
    }

    private int quickSelect(int[] nums, int low, int high, int targetIndex) {
        if (low == high) {
            return nums[low];
        }

        int pivotIndex = low + random.nextInt(high - low + 1);
        int finalPivotIndex = partition(nums, low, high, pivotIndex);

        if (finalPivotIndex == targetIndex) {
            return nums[finalPivotIndex];
        } else if (finalPivotIndex < targetIndex) {
            return quickSelect(nums, finalPivotIndex + 1, high, targetIndex);
        } else {
            return quickSelect(nums, low, finalPivotIndex - 1, targetIndex);
        }
    }

    private int partition(int[] nums, int low, int high, int pivotIndex) {
        int pivotValue = nums[pivotIndex];
        swap(nums, pivotIndex, high); // Move pivot to the end

        int storeIndex = low;
        for (int i = low; i < high; i++) {
            if (nums[i] < pivotValue) {
                swap(nums, storeIndex, i);
                storeIndex++;
            }
        }

        swap(nums, storeIndex, high); // Move pivot to its final sorted position
        return storeIndex;
    }

    private void swap(int[] nums, int i, int j) {
        if (i == j) {
            return;
        }
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
}