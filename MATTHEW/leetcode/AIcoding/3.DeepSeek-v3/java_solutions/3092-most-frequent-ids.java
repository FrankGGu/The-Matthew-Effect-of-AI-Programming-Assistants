class Solution {
    public long[] mostFrequentIDs(int[] nums, int[] freq) {
        Map<Integer, Long> countMap = new HashMap<>();
        TreeMap<Long, Integer> freqMap = new TreeMap<>();
        long[] result = new long[nums.length];

        for (int i = 0; i < nums.length; i++) {
            int id = nums[i];
            long currentCount = countMap.getOrDefault(id, 0L);
            if (currentCount > 0) {
                freqMap.put(currentCount, freqMap.get(currentCount) - 1);
                if (freqMap.get(currentCount) == 0) {
                    freqMap.remove(currentCount);
                }
            }

            long newCount = currentCount + freq[i];
            countMap.put(id, newCount);

            if (newCount > 0) {
                freqMap.put(newCount, freqMap.getOrDefault(newCount, 0) + 1);
            }

            result[i] = freqMap.isEmpty() ? 0 : freqMap.lastKey();
        }

        return result;
    }
}