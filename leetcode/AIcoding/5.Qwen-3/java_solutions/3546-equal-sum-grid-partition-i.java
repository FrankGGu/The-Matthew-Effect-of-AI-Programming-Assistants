public class Solution {
    public boolean isPossibleToSplit(int[] nums) {
        int[] count = new int[101];
        for (int num : nums) {
            count[num]++;
        }
        for (int i = 0; i <= 100; i++) {
            if (count[i] > 2) {
                return false;
            }
        }
        return true;
    }
}