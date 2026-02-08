public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> separateDigits(int[] nums) {
        List<Integer> result = new ArrayList<>();
        for (int num : nums) {
            String numStr = String.valueOf(num);
            for (char c : numStr.toCharArray()) {
                result.add(Character.getNumericValue(c));
            }
        }
        return result;
    }
}
}