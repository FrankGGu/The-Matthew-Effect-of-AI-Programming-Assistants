import java.util.*;

class Solution {
    private int[] count;
    private int[] indexes;

    public List<Integer> countSmaller(int[] nums) {
        List<Integer> result = new ArrayList<>();
        if (nums == null || nums.length == 0) {
            return result;
        }
        int n = nums.length;
        count = new int[n];
        indexes = new int[n];
        for (int i = 0; i < n; i++) {
            indexes[i] = i;
        }
        mergeSort(nums, 0, n - 1);
        for (int i = 0; i < n; i++) {
            result.add(count[i]);
        }
        return result;
    }

    private void mergeSort(int[] nums, int start, int end) {
        if (start >= end) {
            return;
        }
        int mid = start + (end - start) / 2;
        mergeSort(nums, start, mid);
        mergeSort(nums, mid + 1, end);
        merge(nums, start, end);
    }

    private void merge(int[] nums, int start, int end) {
        int mid = start + (end - start) / 2;
        int left = start;
        int right = mid + 1;
        int rightCount = 0;
        int[] newIndexes = new int[end - start + 1];
        int idx = 0;
        while (left <= mid && right <= end) {
            if (nums[indexes[right]] < nums[indexes[left]]) {
                newIndexes[idx] = indexes[right];
                rightCount++;
                right++;
            } else {
                newIndexes[idx] = indexes[left];
                count[indexes[left]] += rightCount;
                left++;
            }
            idx++;
        }
        while (left <= mid) {
            newIndexes[idx] = indexes[left];
            count[indexes[left]] += rightCount;
            left++;
            idx++;
        }
        while (right <= end) {
            newIndexes[idx] = indexes[right];
            right++;
            idx++;
        }
        for (int i = start; i <= end; i++) {
            indexes[i] = newIndexes[i - start];
        }
    }
}