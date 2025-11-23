public class Solution {
    public int deleteAndEarn(int n, int[] nums) {
        int[] count = new int[10001];
        for (int num : nums) {
            count[num]++;
        }

        int prev = 0, curr = 0;
        for (int i = 0; i <= 10000; i++) {
            int temp = curr;
            curr = Math.max(curr, prev + i * count[i]);
            prev = temp;
        }
        return curr;
    }
}