public class Solution {

import java.util.*;

public class Solution {
    public int minDeletions(int[] nums, int[] numsDivide) {
        Arrays.sort(numsDivide);
        Set<Integer> divisors = new HashSet<>();
        for (int num : numsDivide) {
            divisors.add(num);
        }
        Arrays.sort(nums);
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            boolean found = false;
            for (int j = 0; j < numsDivide.length; j++) {
                if (numsDivide[j] % nums[i] == 0) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                count++;
            }
        }
        return count;
    }
}
}