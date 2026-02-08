public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int countTriplets(int[] nums) {
        Set<Integer> set = new HashSet<>();
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                int xor = nums[i] ^ nums[j];
                if (set.contains(xor)) {
                    count++;
                } else {
                    set.add(xor);
                }
            }
        }
        return count;
    }
}
}