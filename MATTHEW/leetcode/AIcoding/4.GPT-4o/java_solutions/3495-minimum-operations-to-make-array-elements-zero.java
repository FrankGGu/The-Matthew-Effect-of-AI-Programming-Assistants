import java.util.HashSet;

class Solution {
    public int minimumOperations(int[] nums) {
        HashSet<Integer> uniqueNonZero = new HashSet<>();
        for (int num : nums) {
            if (num != 0) {
                uniqueNonZero.add(num);
            }
        }
        return uniqueNonZero.size();
    }
}