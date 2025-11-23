public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> countSmaller(int[] nums) {
        List<Integer> result = new ArrayList<>();
        int[] indexes = new int[nums.length];
        for (int i = 0; i < nums.length; i++) {
            indexes[i] = i;
        }
        mergeSort(nums, indexes, 0, nums.length - 1, result);
        return result;
    }

    private void mergeSort(int[] nums, int[] indexes, int left, int right, List<Integer> result) {
        if (left >= right) return;
        int mid = left + (right - left) / 2;
        mergeSort(nums, indexes, left, mid, result);
        mergeSort(nums, indexes, mid + 1, right, result);
        merge(nums, indexes, left, mid, right, result);
    }

    private void merge(int[] nums, int[] indexes, int left, int mid, int right, List<Integer> result) {
        int[] temp = new int[right - left + 1];
        int i = left;
        int j = mid + 1;
        int k = 0;
        int count = 0;

        while (i <= mid && j <= right) {
            if (nums[indexes[i]] > nums[indexes[j]]) {
                temp[k++] = indexes[i++];
                count++;
            } else {
                temp[k++] = indexes[j++];
                result.set(indexes[j - 1], result.get(indexes[j - 1]) + count);
            }
        }

        while (i <= mid) {
            temp[k++] = indexes[i++];
            count++;
        }

        while (j <= right) {
            temp[k++] = indexes[j++];
            result.set(indexes[j - 1], result.get(indexes[j - 1]) + count);
        }

        for (int m = 0; m < temp.length; m++) {
            indexes[left + m] = temp[m];
        }
    }
}
}