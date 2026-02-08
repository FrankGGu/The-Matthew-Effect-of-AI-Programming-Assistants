public class Solution {

import java.util.*;

public class Solution {
    public int[] maxNumber(int[] nums1, int[] nums2, int k) {
        int[] result = new int[k];
        int start = Math.max(0, k - nums2.length);
        int end = Math.min(k, nums1.length);
        for (int i = start; i <= end; i++) {
            int[] candidate = merge(maxSubsequence(nums1, i), maxSubsequence(nums2, k - i));
            if (compare(candidate, 0, result, 0) > 0) {
                result = candidate;
            }
        }
        return result;
    }

    private int[] maxSubsequence(int[] nums, int k) {
        int[] result = new int[k];
        int j = 0;
        for (int i = 0; i < nums.length; i++) {
            while (j > 0 && nums[i] > result[j - 1] && nums.length - i > k - j) {
                j--;
            }
            if (j < k) {
                result[j++] = nums[i];
            }
        }
        return result;
    }

    private int[] merge(int[] nums1, int[] nums2) {
        int[] result = new int[nums1.length + nums2.length];
        int i = 0, j = 0, r = 0;
        while (i < nums1.length || j < nums2.length) {
            if (i < nums1.length && j < nums2.length) {
                if (nums1[i] > nums2[j]) {
                    result[r++] = nums1[i++];
                } else if (nums1[i] < nums2[j]) {
                    result[r++] = nums2[j++];
                } else {
                    int a = i, b = j;
                    while (a < nums1.length && b < nums2.length && nums1[a] == nums2[b]) {
                        a++;
                        b++;
                    }
                    if (a < nums1.length && b < nums2.length) {
                        result[r++] = nums1[i++] > nums2[j++] ? nums1[i - 1] : nums2[j - 1];
                    } else if (a < nums1.length) {
                        result[r++] = nums1[i++];
                    } else {
                        result[r++] = nums2[j++];
                    }
                }
            } else if (i < nums1.length) {
                result[r++] = nums1[i++];
            } else {
                result[r++] = nums2[j++];
            }
        }
        return result;
    }

    private int compare(int[] nums1, int i, int[] nums2, int j) {
        while (i < nums1.length && j < nums2.length) {
            if (nums1[i] > nums2[j]) return 1;
            if (nums1[i] < nums2[j]) return -1;
            i++;
            j++;
        }
        if (nums1.length == nums2.length) return 0;
        return nums1.length > nums2.length ? 1 : -1;
    }
}
}