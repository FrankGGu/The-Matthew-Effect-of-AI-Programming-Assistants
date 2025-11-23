import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

class Solution {
    public int minSetSize(int[] arr) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : arr) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
        }

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        for (int count : frequencyMap.values()) {
            maxHeap.offer(count);
        }

        int size = arr.length;
        int removedElements = 0;
        int sets = 0;

        while (removedElements < size / 2) {
            removedElements += maxHeap.poll();
            sets++;
        }

        return sets;
    }
}