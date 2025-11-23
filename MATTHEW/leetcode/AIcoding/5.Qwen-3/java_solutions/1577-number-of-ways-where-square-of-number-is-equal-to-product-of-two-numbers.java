public class Solution {

import java.util.*;

public class Solution {
    public int numTriplets(int[] nums1, int[] nums2) {
        Map<Integer, Integer> count1 = new HashMap<>();
        Map<Integer, Integer> count2 = new HashMap<>();

        for (int num : nums1) {
            count1.put(num, count1.getOrDefault(num, 0) + 1);
        }

        for (int num : nums2) {
            count2.put(num, count2.getOrDefault(num, 0) + 1);
        }

        int result = 0;

        for (int num : nums1) {
            int square = num * num;
            result += count2.getOrDefault(square, 0);
        }

        for (int num : nums2) {
            int square = num * num;
            result += count1.getOrDefault(square, 0);
        }

        return result;
    }
}
}