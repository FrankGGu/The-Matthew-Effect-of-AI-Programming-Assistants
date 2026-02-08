import java.util.Arrays;

class Solution {
    public int purchasePlans(int[] costs, int money) {
        Arrays.sort(costs);
        int left = 0, right = costs.length - 1;
        int count = 0;
        while (left < right) {
            if (costs[left] + costs[right] <= money) {
                count = (count + (right - left)) % 1000000007;
                left++;
            } else {
                right--;
            }
        }
        return count;
    }
}