import java.util.HashMap;
import java.util.Map;

class Solution {
    public long numberOfGoodPairs(int[] nums1, int[] nums2, int k) {
        long totalGoodPairs = 0;
        Map<Integer, Integer> freqNums2Suffix = new HashMap<>();

        // Populate initial frequencies of all nums2 values
        for (int x : nums2) {
            freqNums2Suffix.put(x, freqNums2Suffix.getOrDefault(x, 0) + 1);
        }

        for (int i = 0; i < nums1.length; i++) {
            // Before processing nums1[i], remove nums2[i] from the suffix map.
            // This ensures freqNums2Suffix contains counts for nums2[j] where j > i.
            freqNums2Suffix.put(nums2[i], freqNums2Suffix.get(nums2[i]) - 1);
            if (freqNums2Suffix.get(nums2[i]) == 0) {
                freqNums2Suffix.remove(nums2[i]);
            }

            // Check if nums1[i] is divisible by k. If not, nums1[i] cannot be divisible by nums2[j] * k.
            if (nums1[i] % k == 0) {
                long valDivK = nums1[i] / k;

                // Find all divisors 'd' of valDivK.
                // For each divisor 'd', if it exists in freqNums2Suffix, add its count to totalGoodPairs.
                for (long d = 1; d * d <= valDivK; d++) {
                    if (valDivK % d == 0) {
                        // 'd' is a divisor
                        if (freqNums2Suffix.containsKey((int) d)) {
                            totalGoodPairs += freqNums2Suffix.get((int) d);
                        }

                        // 'valDivK / d' is also a divisor
                        // Avoid double counting if d * d == valDivK (i.e., d is the square root)
                        if (d * d != valDivK) {
                            long d2 = valDivK / d;
                            if (freqNums2Suffix.containsKey((int) d2)) {
                                totalGoodPairs += freqNums2Suffix.get((int) d2);
                            }
                        }
                    }
                }
            }
        }

        return totalGoodPairs;
    }
}