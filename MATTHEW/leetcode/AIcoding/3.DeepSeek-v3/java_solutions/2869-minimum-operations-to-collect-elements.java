class Solution {
    public int minOperations(List<Integer> nums, int k) {
        Set<Integer> collected = new HashSet<>();
        int operations = 0;
        for (int i = nums.size() - 1; i >= 0; i--) {
            operations++;
            int num = nums.get(i);
            if (num <= k) {
                collected.add(num);
                if (collected.size() == k) {
                    return operations;
                }
            }
        }
        return operations;
    }
}