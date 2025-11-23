import java.util.*;

public class Solution {
    public int[] rearrangeBarcodes(int[] barcodes) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int barcode : barcodes) {
            countMap.put(barcode, countMap.getOrDefault(barcode, 0) + 1);
        }

        PriorityQueue<int[]> maxHeap = new PriorityQueue<>((a, b) -> b[1] - a[1]);
        for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
            maxHeap.offer(new int[]{entry.getKey(), entry.getValue()});
        }

        int[] result = new int[barcodes.length];
        int index = 0;

        while (!maxHeap.isEmpty()) {
            int[] current = maxHeap.poll();
            int barcode = current[0];
            int count = current[1];

            for (int i = 0; i < count; i++) {
                if (index >= barcodes.length) {
                    index = 1; // Start filling odd indices
                }
                result[index] = barcode;
                index += 2; // Move to the next index
            }
        }

        return result;
    }
}