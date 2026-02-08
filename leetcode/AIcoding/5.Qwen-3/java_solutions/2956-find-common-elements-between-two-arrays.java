public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findCommonElements(int[] nums1, int[] nums2) {
        Set<Integer> set1 = new HashSet<>();
        for (int num : nums1) {
            set1.add(num);
        }
        Set<Integer> common = new HashSet<>();
        for (int num : nums2) {
            if (set1.contains(num)) {
                common.add(num);
            }
        }
        return new ArrayList<>(common);
    }
}
}