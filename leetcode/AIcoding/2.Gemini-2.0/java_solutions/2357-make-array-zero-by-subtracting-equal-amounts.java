import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minimumOperations(int[] nums) {
        Set<Integer> distinctPositiveNumbers = new HashSet<>();
        for (int num : nums) {
            if (num > 0) {
                distinctPositiveNumbers.add(num);
            }
        }
        return distinctPositiveNumbers.size();
    }
}