public class Solution {

import java.util.*;

public class Solution {
    public long minOperations(int[] nums1, int[] nums2) {
        int n = nums1.length;
        long diff = 0;
        for (int i = 0; i < n; i++) {
            diff += nums2[i] - nums1[i];
        }
        if (diff == 0) return 0;
        long ops = 0;
        for (int i = 0; i < n; i++) {
            int d = nums2[i] - nums1[i];
            if (d != 0) {
                if (diff > 0) {
                    if (d > 0) {
                        ops += d;
                        diff -= d;
                    } else {
                        ops += -d;
                        diff += -d;
                    }
                } else {
                    if (d < 0) {
                        ops += -d;
                        diff += d;
                    } else {
                        ops += d;
                        diff -= d;
                    }
                }
            }
        }
        return ops;
    }
}
}