import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int specialPerm(int[] nums) {
        return backtrack(nums, new boolean[nums.length], -1, 0);
    }

    private int backtrack(int[] nums, boolean[] used, int prev, int count) {
        if (count == nums.length) return 1;
        int total = 0;

        for (int i = 0; i < nums.length; i++) {
            if (!used[i] && (prev == -1 || gcd(prev, nums[i]) > 1)) {
                used[i] = true;
                total += backtrack(nums, used, nums[i], count + 1);
                used[i] = false;
            }
        }
        return total;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}