class Solution {
    public int countNicePairs(int[] nums) {
        int mod = 1_000_000_007;
        long count = 0;
        Map<Long, Long> map = new HashMap<>();

        for (int num : nums) {
            long rev = reverse(num);
            long key = (long) num - rev;
            count = (count + map.getOrDefault(key, 0L)) % mod;
            map.put(key, map.getOrDefault(key, 0L) + 1);
        }

        return (int) count;
    }

    private long reverse(int num) {
        long rev = 0;
        while (num > 0) {
            rev = rev * 10 + num % 10;
            num /= 10;
        }
        return rev;
    }
}