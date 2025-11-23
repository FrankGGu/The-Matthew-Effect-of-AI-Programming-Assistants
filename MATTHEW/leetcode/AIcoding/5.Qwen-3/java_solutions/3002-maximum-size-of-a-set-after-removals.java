public class Solution {

import java.util.*;

public class Solution {
    public int maximumSetSize(int[] nums1, int[] nums2) {
        Set<Integer> set1 = new HashSet<>();
        Set<Integer> set2 = new HashSet<>();
        for (int num : nums1) {
            set1.add(num);
        }
        for (int num : nums2) {
            set2.add(num);
        }
        Set<Integer> intersection = new HashSet<>(set1);
        intersection.retainAll(set2);
        int common = intersection.size();
        int size1 = set1.size();
        int size2 = set2.size();
        int total = size1 + size2 - common;
        int max = Math.min(total, 2 * (nums1.length / 2));
        return max;
    }
}
}