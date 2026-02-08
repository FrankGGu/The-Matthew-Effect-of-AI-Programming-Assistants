class Solution {
    public long minElements(int[] nums, int limit, int goal) {
        long currentSum = 0;
        for (int num : nums) {
            currentSum += num;
        }

        long diff = goal - currentSum;
        long absDiff = Math.abs(diff);

        // To minimize the number of elements, each added element should have the maximum possible absolute value, which is 'limit'.
        // We need to cover a total difference of 'absDiff' using elements that can contribute at most 'limit' each.
        // This is equivalent to calculating ceil(absDiff / limit).
        // For positive integers a and b, ceil(a/b) can be computed using integer division as (a + b - 1) / b.
        return (absDiff + limit - 1) / limit;
    }
}