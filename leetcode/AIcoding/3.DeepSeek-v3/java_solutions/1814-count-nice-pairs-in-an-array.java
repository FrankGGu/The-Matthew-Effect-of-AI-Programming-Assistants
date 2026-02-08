class Solution {
    public int countNicePairs(int[] nums) {
        final int MOD = 1000000007;
        Map<Integer, Integer> map = new HashMap<>();
        int res = 0;
        for (int num : nums) {
            int rev = reverse(num);
            int diff = num - rev;
            int count = map.getOrDefault(diff, 0);
            res = (res + count) % MOD;
            map.put(diff, count + 1);
        }
        return res;
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