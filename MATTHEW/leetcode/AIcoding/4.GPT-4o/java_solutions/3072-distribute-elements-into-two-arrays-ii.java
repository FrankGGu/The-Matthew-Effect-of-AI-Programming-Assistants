import java.util.Arrays;

public class Solution {
    public boolean canDistribute(int[] nums, int[] quantity) {
        int n = nums.length;
        int totalQuantity = Arrays.stream(quantity).sum();
        if (totalQuantity > n) return false;

        int[] count = new int[100001];
        for (int num : nums) {
            count[num]++;
        }

        int[] freq = Arrays.stream(count).filter(x -> x > 0).toArray();
        return backtrack(freq, quantity, 0, new int[quantity.length]);
    }

    private boolean backtrack(int[] freq, int[] quantity, int i, int[] used) {
        if (i == quantity.length) return true;
        for (int j = 0; j < freq.length; j++) {
            if (freq[j] >= quantity[i]) {
                freq[j] -= quantity[i];
                if (backtrack(freq, quantity, i + 1, used)) return true;
                freq[j] += quantity[i];
            }
        }
        return false;
    }
}