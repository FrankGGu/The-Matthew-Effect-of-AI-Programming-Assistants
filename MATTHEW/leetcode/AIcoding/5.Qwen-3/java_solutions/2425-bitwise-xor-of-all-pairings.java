public class Solution {

import java.util.*;

public class Solution {
    public int xorAllElements(int[] nums1, int[] nums2) {
        int result = 0;
        for (int num : nums1) {
            for (int num2 : nums2) {
                result ^= num ^ num2;
            }
        }
        return result;
    }
}
}