public class Solution {

import java.util.*;

public class Solution {
    public int minSumSquareDifference(int[] nums1, int[] nums2, int k1, int[] nums3, int[] nums4, int k2) {
        int n = nums1.length;
        List<int[]> diffs = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            int diff = nums1[i] - nums2[i];
            if (diff < 0) diff = -diff;
            diffs.add(new int[]{diff, i});
        }

        diffs.sort((a, b) -> b[0] - a[0]);

        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = nums1[i] - nums2[i];
            if (nums[i] < 0) nums[i] = -nums[i];
        }

        int[] ops = new int[n];
        for (int i = 0; i < n; i++) {
            ops[i] = nums3[i] - nums4[i];
            if (ops[i] < 0) ops[i] = -ops[i];
        }

        int totalK = k1 + k2;
        int[] counts = new int[n];

        for (int i = 0; i < n; i++) {
            counts[i] = Math.min(k1, Math.min(k2, Math.abs(nums[i] - ops[i])));
            if (counts[i] > 0) {
                if (nums[i] > ops[i]) {
                    nums[i] -= counts[i];
                } else {
                    nums[i] += counts[i];
                }
                k1 -= counts[i];
                k2 -= counts[i];
            }
        }

        for (int i = 0; i < n && (k1 > 0 || k2 > 0); i++) {
            int maxDiff = Math.abs(nums[i] - ops[i]);
            int use = Math.min(k1, k2);
            if (use > 0) {
                if (nums[i] > ops[i]) {
                    nums[i] -= use;
                } else {
                    nums[i] += use;
                }
                k1 -= use;
                k2 -= use;
            } else {
                use = Math.min(k1, maxDiff);
                if (use > 0) {
                    if (nums[i] > ops[i]) {
                        nums[i] -= use;
                    } else {
                        nums[i] += use;
                    }
                    k1 -= use;
                } else {
                    use = Math.min(k2, maxDiff);
                    if (use > 0) {
                        if (nums[i] > ops[i]) {
                            nums[i] -= use;
                        } else {
                            nums[i] += use;
                        }
                        k2 -= use;
                    }
                }
            }
        }

        int sum = 0;
        for (int i = 0; i < n; i++) {
            sum += nums[i] * nums[i];
        }

        return sum;
    }
}
}