import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

class Solution {
    public boolean isPossibleDivide(int[] nums, int k) {
        if (nums.length % k != 0) {
            return false;
        }

        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        PriorityQueue<Integer> minHeap = new PriorityQueue<>(countMap.keySet());

        while (!minHeap.isEmpty()) {
            int start = minHeap.peek();
            for (int i = 0; i < k; i++) {
                int current = start + i;
                if (!countMap.containsKey(current)) {
                    return false;
                }
                countMap.put(current, countMap.get(current) - 1);
                if (countMap.get(current) == 0) {
                    if (current == minHeap.peek()) {
                        minHeap.poll();
                    }
                    countMap.remove(current);
                }
            }
        }

        return true;
    }
}