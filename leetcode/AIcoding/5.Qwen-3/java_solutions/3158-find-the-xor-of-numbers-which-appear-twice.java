public class Solution {

import java.util.*;

public class Solution {
    public int duplicateNumbersXOR(int[] nums) {
        Set<Integer> seen = new HashSet<>();
        Set<Integer> duplicates = new HashSet<>();

        for (int num : nums) {
            if (seen.contains(num)) {
                duplicates.add(num);
            } else {
                seen.add(num);
            }
        }

        int result = 0;
        for (int num : duplicates) {
            result ^= num;
        }

        return result;
    }
}
}