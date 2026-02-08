import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minimumOperations(int[] nums, int k) {
        Set<Integer> collectedElements = new HashSet<>();
        int operations = 0;

        for (int i = nums.length - 1; i >= 0; i--) {
            operations++;
            int currentNum = nums[i];
            if (currentNum >= 1 && currentNum <= k) {
                collectedElements.add(currentNum);
            }
            if (collectedElements.size() == k) {
                return operations;
            }
        }
        return operations; // Should not be reached if k is always collectable
    }
}