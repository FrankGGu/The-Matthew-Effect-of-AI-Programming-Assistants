import java.util.HashMap;
import java.util.PriorityQueue;

class Solution {
    public int findLeastNumOfUniqueInts(int[] arr, int k) {
        HashMap<Integer, Integer> countMap = new HashMap<>();
        for (int num : arr) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> countMap.get(a) - countMap.get(b));
        pq.addAll(countMap.keySet());

        while (k > 0 && !pq.isEmpty()) {
            int num = pq.peek();
            if (countMap.get(num) <= k) {
                k -= countMap.get(num);
                pq.poll();
            } else {
                break;
            }
        }

        return pq.size();
    }
}