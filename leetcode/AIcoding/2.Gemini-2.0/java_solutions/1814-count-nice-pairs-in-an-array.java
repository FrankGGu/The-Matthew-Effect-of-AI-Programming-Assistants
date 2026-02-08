class Solution {
    public int countNicePairs(int[] nums) {
        int MOD = 1000000007;
        int count = 0;
        HashMap<Integer, Integer> map = new HashMap<>();

        for (int num : nums) {
            int diff = num - rev(num);
            if (map.containsKey(diff)) {
                count = (count + map.get(diff)) % MOD;
                map.put(diff, map.get(diff) + 1);
            } else {
                map.put(diff, 1);
            }
        }

        return count;
    }

    private int rev(int num) {
        int reversed = 0;
        while (num > 0) {
            int digit = num % 10;
            reversed = reversed * 10 + digit;
            num /= 10;
        }
        return reversed;
    }
}