import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<Boolean> checkArithmeticSubarrays(int[] nums, int[] l, int[] r) {
        List<Boolean> result = new ArrayList<>();
        for (int i = 0; i < l.length; i++) {
            int left = l[i];
            int right = r[i];
            int[] subarray = Arrays.copyOfRange(nums, left, right + 1);
            Arrays.sort(subarray);
            boolean isArithmetic = true;
            if (subarray.length > 1) {
                int diff = subarray[1] - subarray[0];
                for (int j = 2; j < subarray.length; j++) {
                    if (subarray[j] - subarray[j - 1] != diff) {
                        isArithmetic = false;
                        break;
                    }
                }
            }
            result.add(isArithmetic);
        }
        return result;
    }
}