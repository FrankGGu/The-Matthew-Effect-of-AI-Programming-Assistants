public class Solution {
    public int numGoodPairs(int[] nums) {
        int count = 0;
        int[] freq = new int[101];
        for (int num : nums) {
            count += freq[num];
            freq[num]++;
        }
        return count;
    }
}