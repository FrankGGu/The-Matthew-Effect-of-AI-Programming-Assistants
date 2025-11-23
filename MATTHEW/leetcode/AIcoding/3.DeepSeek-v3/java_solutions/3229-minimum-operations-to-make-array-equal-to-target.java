class Solution {
    public int minOperations(int[] nums, int[] target) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int operations = 0;
        for (int t : target) {
            if (!freq.containsKey(t) || freq.get(t) <= 0) {
                return -1;
            }
            freq.put(t, freq.get(t) - 1);
        }

        for (Map.Entry<Integer, Integer> entry : freq.entrySet()) {
            operations += entry.getValue();
        }

        return operations;
    }
}