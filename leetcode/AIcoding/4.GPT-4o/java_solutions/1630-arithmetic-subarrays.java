import java.util.List;
import java.util.ArrayList;

class Solution {
    public List<Boolean> checkArithmeticSubarrays(int[] nums, int[] l, int[] r) {
        List<Boolean> result = new ArrayList<>();
        for (int i = 0; i < l.length; i++) {
            int start = l[i];
            int end = r[i];
            int length = end - start + 1;
            if (length < 2) {
                result.add(true);
                continue;
            }
            int[] subarray = new int[length];
            for (int j = 0; j < length; j++) {
                subarray[j] = nums[start + j];
            }
            Arrays.sort(subarray);
            int diff = subarray[1] - subarray[0];
            boolean isArithmetic = true;
            for (int j = 2; j < length; j++) {
                if (subarray[j] - subarray[j - 1] != diff) {
                    isArithmetic = false;
                    break;
                }
            }
            result.add(isArithmetic);
        }
        return result;
    }
}