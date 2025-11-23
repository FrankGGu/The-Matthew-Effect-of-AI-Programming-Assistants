public class Solution {

import java.util.*;

public class Solution {
    public int maxDistance(List<Integer> nums1, List<Integer> nums2) {
        int maxDist = 0;
        int i = 0;
        int j = 0;
        while (i < nums1.size() && j < nums2.size()) {
            if (nums1.get(i) > nums2.get(j)) {
                i++;
            } else if (nums1.get(i) <= nums2.get(j)) {
                if (i < j) {
                    maxDist = Math.max(maxDist, j - i);
                }
                j++;
            }
        }
        return maxDist;
    }
}
}