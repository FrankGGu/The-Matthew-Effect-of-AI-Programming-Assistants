public class Solution {

import java.util.*;

public class DistantBarcodes {
    public void reorganizeBarcodes(int[] barcodes) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int code : barcodes) {
            count.put(code, count.getOrDefault(code, 0) + 1);
        }

        PriorityQueue<Map.Entry<Integer, Integer>> maxHeap = new PriorityQueue<>((a, b) -> b.getValue() - a.getValue());
        maxHeap.addAll(count.entrySet());

        int index = 0;
        while (maxHeap.size() > 1) {
            Map.Entry<Integer, Integer> first = maxHeap.poll();
            Map.Entry<Integer, Integer> second = maxHeap.poll();

            barcodes[index++] = first.getKey();
            barcodes[index++] = second.getKey();

            first.setValue(first.getValue() - 1);
            second.setValue(second.getValue() - 1);

            if (first.getValue() > 0) {
                maxHeap.add(first);
            }
            if (second.getValue() > 0) {
                maxHeap.add(second);
            }
        }

        if (maxHeap.size() == 1) {
            Map.Entry<Integer, Integer> last = maxHeap.poll();
            while (last.getValue() > 0) {
                barcodes[index++] = last.getKey();
                last.setValue(last.getValue() - 1);
            }
        }
    }
}
}