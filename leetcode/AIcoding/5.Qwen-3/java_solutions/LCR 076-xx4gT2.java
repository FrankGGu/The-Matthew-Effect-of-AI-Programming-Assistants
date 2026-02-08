public class Solution {

import java.util.Random;

public class Solution {
    public int findKthLargest(int[] nums, int k) {
        int n = nums.length;
        int left = 0;
        int right = n - 1;
        Random random = new Random();
        while (left <= right) {
            int pivotIndex = partition(nums, left, right, random);
            if (pivotIndex == n - k) {
                return nums[pivotIndex];
            } else if (pivotIndex < n - k) {
                left = pivotIndex + 1;
            } else {
                right = pivotIndex - 1;
            }
        }
        return -1;
    }

    private int partition(int[] nums, int left, int right, Random random) {
        int pivotIndex = left + random.nextInt(right - left + 1);
        int pivot = nums[pivotIndex];
        swap(nums, pivotIndex, right);
        int i = left;
        for (int j = left; j < right; j++) {
            if (nums[j] >= pivot) {
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
}