class Solution {
    public long minimalKSum(int[] nums, int k) {
        Arrays.sort(nums);
        long sum = 0;
        long prev = 0;
        for (int num : nums) {
            if (num == prev) continue;
            long count = Math.min(k, num - prev - 1);
            if (count > 0) {
                sum += (prev + 1 + prev + count) * count / 2;
                k -= count;
            }
            prev = num;
            if (k == 0) break;
        }
        if (k > 0) {
            sum += (prev + 1 + prev + k) * k / 2;
        }
        return sum;
    }
}