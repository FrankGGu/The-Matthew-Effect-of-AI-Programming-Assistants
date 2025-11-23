public class Solution {

import java.util.*;

public class Solution {
    public String minNumber(int[] nums1, int[] nums2) {
        Set<Integer> set1 = new HashSet<>();
        Set<Integer> set2 = new HashSet<>();

        for (int num : nums1) {
            set1.add(num);
        }

        for (int num : nums2) {
            set2.add(num);
        }

        int common = Integer.MAX_VALUE;
        for (int num : set1) {
            if (set2.contains(num)) {
                common = Math.min(common, num);
            }
        }

        if (common != Integer.MAX_VALUE) {
            return String.valueOf(common);
        }

        int min1 = Collections.min(set1);
        int min2 = Collections.min(set2);

        return String.valueOf(Math.min(min1 * 10 + min2, min2 * 10 + min1));
    }
}
}