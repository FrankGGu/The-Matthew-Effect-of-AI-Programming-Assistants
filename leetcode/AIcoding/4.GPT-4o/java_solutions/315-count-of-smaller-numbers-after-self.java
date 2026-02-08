import java.util.*;

class Solution {
    public List<Integer> countSmaller(int[] nums) {
        int n = nums.length;
        int[] counts = new int[n];
        Integer[] index = new Integer[n];
        for (int i = 0; i < n; i++) {
            index[i] = i;
        }
        mergeSort(nums, index, counts, 0, n - 1);
        return Arrays.asList(counts);
    }

    private void mergeSort(int[] nums, Integer[] index, int[] counts, int left, int right) {
        if (left >= right) return;
        int mid = left + (right - left) / 2;
        mergeSort(nums, index, counts, left, mid);
        mergeSort(nums, index, counts, mid + 1, right);
        merge(nums, index, counts, left, mid, right);
    }

    private void merge(int[] nums, Integer[] index, int[] counts, int left, int mid, int right) {
        int j = mid + 1;
        for (int i = left; i <= mid; i++) {
            while (j <= right && nums[index[i]] > nums[index[j]]) {
                j++;
            }
            counts[index[i]] += j - (mid + 1);
        }
        Arrays.sort(index, left, right + 1, (a, b) -> Integer.compare(nums[a], nums[b]));
    }
}