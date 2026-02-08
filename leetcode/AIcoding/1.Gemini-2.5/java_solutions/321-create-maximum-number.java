class Solution {
    public int[] maxNumber(int[] nums1, int[] nums2, int k) {
        int n1 = nums1.length;
        int n2 = nums2.length;
        int[] maxResult = new int[k];

        for (int i = Math.max(0, k - n2); i <= Math.min(k, n1); i++) {
            int[] sub1 = maxArray(nums1, i);
            int[] sub2 = maxArray(nums2, k - i);
            int[] merged = merge(sub1, sub2);
            if (compare(merged, 0, maxResult, 0)) {
                maxResult = merged;
            }
        }

        return maxResult;
    }

    private int[] maxArray(int[] nums, int len) {
        if (len == 0) {
            return new int[0];
        }
        int[] result = new int[len];
        int drop = nums.length - len;
        int idx = 0;
        for (int num : nums) {
            while (drop > 0 && idx > 0 && num > result[idx - 1]) {
                idx--;
                drop--;
            }
            if (idx < len) {
                result[idx++] = num;
            } else {
                drop--;
            }
        }
        return result;
    }

    private int[] merge(int[] nums1, int[] nums2) {
        int[] result = new int[nums1.length + nums2.length];
        int p1 = 0, p2 = 0, pr = 0;
        while (p1 < nums1.length || p2 < nums2.length) {
            if (compare(nums1, p1, nums2, p2)) {
                result[pr++] = nums1[p1++];
            } else {
                result[pr++] = nums2[p2++];
            }
        }
        return result;
    }

    private boolean compare(int[] nums1, int idx1, int[] nums2, int idx2) {
        while (idx1 < nums1.length && idx2 < nums2.length && nums1[idx1] == nums2[idx2]) {
            idx1++;
            idx2++;
        }
        return idx1 == nums1.length ? false : (idx2 == nums2.length ? true : nums1[idx1] > nums2[idx2]);
    }
}