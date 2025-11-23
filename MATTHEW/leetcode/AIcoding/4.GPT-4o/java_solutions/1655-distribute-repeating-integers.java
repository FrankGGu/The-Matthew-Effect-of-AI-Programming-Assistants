import java.util.Arrays;

public class Solution {
    public boolean canDistribute(int[] nums, int[] quantity) {
        int n = quantity.length;
        int[] count = new int[101];
        for (int num : nums) {
            count[num]++;
        }
        Arrays.sort(quantity);
        return dfs(count, quantity, n, 0);
    }

    private boolean dfs(int[] count, int[] quantity, int n, int index) {
        if (index == n) return true;
        for (int i = 0; i < count.length; i++) {
            if (count[i] >= quantity[index]) {
                count[i] -= quantity[index];
                if (dfs(count, quantity, n, index + 1)) return true;
                count[i] += quantity[index];
            }
        }
        return false;
    }
}