public class Solution {
    public boolean isPossibleToSplit(int[] nums) {
        int[] count = new int[1001];
        for (int num : nums) {
            count[num]++;
        }
        for (int i = 0; i <= 1000; i++) {
            if (count[i] > 2) {
                return false;
            }
        }
        return true;
    }
}