class Solution {
    public long minimalKSum(int[] nums, int k) {
        long sum = 0;
        Set<Integer> set = new HashSet<>();
        for (int num : nums) {
            if (num > 0) set.add(num);
        }
        int count = 0;
        for (int i = 1; count < k; i++) {
            if (!set.contains(i)) {
                sum += i;
                count++;
            }
        }
        return sum;
    }
}