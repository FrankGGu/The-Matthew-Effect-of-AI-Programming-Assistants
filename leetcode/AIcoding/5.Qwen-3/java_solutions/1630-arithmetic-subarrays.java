public class Solution {

import java.util.*;

public class Solution {
    public List<Boolean> checkArithmeticSubarrays(List<Integer> nums, int[] l, int[] r) {
        List<Boolean> result = new ArrayList<>();
        for (int i = 0; i < l.length; i++) {
            int left = l[i];
            int right = r[i];
            List<Integer> sub = nums.subList(left, right + 1);
            Collections.sort(sub);
            boolean isArithmetic = true;
            int diff = sub.get(1) - sub.get(0);
            for (int j = 2; j < sub.size(); j++) {
                if (sub.get(j) - sub.get(j - 1) != diff) {
                    isArithmetic = false;
                    break;
                }
            }
            result.add(isArithmetic);
        }
        return result;
    }
}
}