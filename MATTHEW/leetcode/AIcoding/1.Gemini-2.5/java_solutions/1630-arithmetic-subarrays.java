import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public List<Boolean> checkArithmeticSubarrays(int[] nums, int[] l, int[] r) {
        List<Boolean> result = new ArrayList<>();
        for (int i = 0; i < l.length; i++) {
            int start = l[i];
            int end = r[i];
            int subArrayLength = end - start + 1;

            if (subArrayLength < 2) {
                result.add(true);
                continue;
            }

            int minVal = Integer.MAX_VALUE;
            int maxVal = Integer.MIN_VALUE;
            Set<Integer> seen = new HashSet<>();

            for (int j = start; j <= end; j++) {
                minVal = Math.min(minVal, nums[j]);
                maxVal = Math.max(maxVal, nums[j]);
                seen.add(nums[j]);
            }

            if (minVal == maxVal) {
                result.add(true);
                continue;
            }

            if ((maxVal - minVal) % (subArrayLength - 1) != 0) {
                result.add(false);
                continue;
            }

            int diff = (maxVal - minVal) / (subArrayLength - 1);

            if (seen.size() != subArrayLength) {
                result.add(false);
                continue;
            }

            boolean isArithmetic = true;
            for (int k = 0; k < subArrayLength; k++) {
                int expected = minVal + k * diff;
                if (!seen.contains(expected)) {
                    isArithmetic = false;
                    break;
                }
            }
            result.add(isArithmetic);
        }
        return result;
    }
}