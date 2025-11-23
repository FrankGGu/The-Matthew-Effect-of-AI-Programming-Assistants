public class Solution {

import java.util.*;

public class Solution {
    public int numberOfPairs(int[] nums1, int[] nums2, int k) {
        int n = nums1.length;
        int count = 0;
        List<Integer> list = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            int target = nums1[i] - k;
            int idx = Collections.binarySearch(list, target);
            if (idx < 0) {
                idx = ~idx;
            }
            count += idx;
            list.add(nums1[i]);
        }
        return count;
    }
}
}