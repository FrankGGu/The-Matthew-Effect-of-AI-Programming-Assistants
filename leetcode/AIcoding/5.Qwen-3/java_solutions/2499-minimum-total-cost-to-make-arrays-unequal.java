public class Solution {

import java.util.*;

public class Solution {
    public int minTotalCostToMakeArraysUnequal(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int m = nums2.length;
        int[] freq1 = new int[1001];
        int[] freq2 = new int[1001];
        for (int num : nums1) {
            freq1[num]++;
        }
        for (int num : nums2) {
            freq2[num]++;
        }
        int totalCost = 0;
        for (int i = 0; i <= 1000; i++) {
            if (freq1[i] != freq2[i]) {
                totalCost += Math.abs(freq1[i] - freq2[i]) * i;
            }
        }
        return totalCost;
    }
}
}