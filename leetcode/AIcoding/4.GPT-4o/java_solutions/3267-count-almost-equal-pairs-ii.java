class Solution {
    public int countPairs(int[] nums) {
        int count = 0;
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int num : nums) {
            count += freqMap.getOrDefault(num, 0);
            count += freqMap.getOrDefault(num - 1, 0);
            count += freqMap.getOrDefault(num + 1, 0);
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }
        return count;
    }
}