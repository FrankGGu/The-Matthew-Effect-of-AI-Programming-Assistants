import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Collections;

class Solution {
    public int minSetSize(int[] arr) {
        int n = arr.length;
        int targetHalf = n / 2;

        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int num : arr) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        for (int freq : freqMap.values()) {
            maxHeap.add(freq);
        }

        int removedCount = 0;
        int setSize = 0;

        while (removedCount < targetHalf) {
            removedCount += maxHeap.poll();
            setSize++;
        }

        return setSize;
    }
}