import java.util.HashSet;
import java.util.Set;

class Solution {
    public int maximumDistinctElements(int[] nums, int k) {
        Set<Integer> distinctElements = new HashSet<>();
        for (int num : nums) {
            distinctElements.add(num);
        }

        int initialDistinctCount = distinctElements.size();
        int n = nums.length;

        return Math.min(n, initialDistinctCount + k);
    }
}