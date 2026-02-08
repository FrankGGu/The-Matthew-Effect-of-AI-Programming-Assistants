class Solution {
    public int numberOfGoodPartitions(int[] nums) {
        Map<Integer, Integer> lastOccurrence = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            lastOccurrence.put(nums[i], i);
        }

        int end = 0;
        int partitions = 0;
        for (int i = 0; i < nums.length; i++) {
            end = Math.max(end, lastOccurrence.get(nums[i]));
            if (i == end) {
                partitions++;
            }
        }

        int result = 1;
        for (int i = 1; i < partitions; i++) {
            result = (result * 2) % 1000000007;
        }
        return result;
    }
}