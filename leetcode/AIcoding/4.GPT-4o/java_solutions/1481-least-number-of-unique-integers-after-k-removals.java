import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

class Solution {
    public int findLeastNumOfUniqueInts(int[] arr, int k) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : arr) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        PriorityQueue<Integer> minHeap = new PriorityQueue<>((a, b) -> countMap.get(a) - countMap.get(b));
        minHeap.addAll(countMap.keySet());

        while (k > 0 && !minHeap.isEmpty()) {
            int num = minHeap.poll();
            k -= countMap.get(num);
            if (k >= 0) {
                countMap.remove(num);
            }
        }

        return countMap.size();
    }
}