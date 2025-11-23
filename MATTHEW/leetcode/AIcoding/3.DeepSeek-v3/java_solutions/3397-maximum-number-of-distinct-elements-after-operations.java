class Solution {
    public int maximumDistinctElements(int[] nums, int k) {
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int num : nums) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }

        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        for (int count : freqMap.values()) {
            if (count > 1) {
                minHeap.offer(count);
            }
        }

        while (k > 0 && !minHeap.isEmpty()) {
            int count = minHeap.poll();
            int operations = count - 1;
            if (k >= operations) {
                k -= operations;
            } else {
                operations = k;
                k = 0;
            }
            if (count - operations == 1) {
                // No need to add back
            } else {
                minHeap.offer(count - operations);
            }
        }

        int distinct = freqMap.size();
        while (k > 0 && distinct > 0) {
            distinct--;
            k--;
        }

        return distinct;
    }
}