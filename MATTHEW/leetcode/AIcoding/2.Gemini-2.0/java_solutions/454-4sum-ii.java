import java.util.HashMap;
import java.util.Map;

class Solution {
    public int fourSumCount(int[] nums1, int[] nums2, int[] nums3, int[] nums4) {
        Map<Integer, Integer> sumMap = new HashMap<>();
        int count = 0;

        for (int num1 : nums1) {
            for (int num2 : nums2) {
                int sum = num1 + num2;
                sumMap.put(sum, sumMap.getOrDefault(sum, 0) + 1);
            }
        }

        for (int num3 : nums3) {
            for (int num4 : nums4) {
                int sum = num3 + num4;
                count += sumMap.getOrDefault(-sum, 0);
            }
        }

        return count;
    }
}