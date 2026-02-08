public class Solution {
    public int maxAlternatingSubsequenceSum(int[] nums) {
        int even = 0, odd = 0;
        for (int num : nums) {
            int newEven = Math.max(even, odd + num);
            int newOdd = Math.max(odd, even - num);
            even = newEven;
            odd = newOdd;
        }
        return even;
    }
}