class Solution {
    public int minOperations(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int operations = 0;
        for (int count : freq.values()) {
            if (count == 1) {
                return -1;
            }
            operations += count / 3;
            if (count % 3 != 0) {
                operations++;
            }
        }
        return operations;
    }
}