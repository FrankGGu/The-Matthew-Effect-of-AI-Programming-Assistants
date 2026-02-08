import java.util.HashSet;

class Solution {
    public int distinctIntegersAfterReverse(int[] nums) {
        HashSet<Integer> set = new HashSet<>();
        for (int num : nums) {
            set.add(num);
        }
        int max = Integer.MIN_VALUE;
        for (int num : nums) {
            max = Math.max(max, Math.max(num, reverse(num)));
        }
        set.add(max);
        return set.size();
    }

    private int reverse(int num) {
        int rev = 0;
        while (num > 0) {
            rev = rev * 10 + num % 10;
            num /= 10;
        }
        return rev;
    }
}