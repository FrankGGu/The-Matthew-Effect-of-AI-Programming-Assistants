import java.util.Arrays;

public class Solution {
    public int[] maxNumber(int[] nums1, int[] nums2, int k) {
        int[] result = new int[k];
        for (int i = Math.max(0, k - nums2.length); i <= Math.min(k, nums1.length); i++) {
            int[] candidate1 = getMaxArray(nums1, i);
            int[] candidate2 = getMaxArray(nums2, k - i);
            int[] merged = merge(candidate1, candidate2);
            if (greater(result, 0, merged, 0)) {
                result = merged;
            }
        }
        return result;
    }

    private int[] getMaxArray(int[] nums, int len) {
        int[] stack = new int[len];
        int drop = nums.length - len;
        for (int num : nums) {
            while (drop > 0 && stack.length > 0 && stack[stack.length - 1] < num) {
                stack = Arrays.copyOf(stack, stack.length - 1);
                drop--;
            }
            if (stack.length < len) {
                stack = Arrays.copyOf(stack, stack.length + 1);
                stack[stack.length - 1] = num;
            } else {
                drop--;
            }
        }
        return stack;
    }

    private int[] merge(int[] nums1, int[] nums2) {
        int[] merged = new int[nums1.length + nums2.length];
        int i = 0, j = 0, index = 0;
        while (i < nums1.length || j < nums2.length) {
            if (greater(nums1, i, nums2, j)) {
                merged[index++] = nums1[i++];
            } else {
                merged[index++] = nums2[j++];
            }
        }
        return merged;
    }

    private boolean greater(int[] nums1, int i, int[] nums2, int j) {
        while (i < nums1.length && j < nums2.length && nums1[i] == nums2[j]) {
            i++;
            j++;
        }
        return j == nums2.length || (i < nums1.length && nums1[i] > nums2[j]);
    }
}