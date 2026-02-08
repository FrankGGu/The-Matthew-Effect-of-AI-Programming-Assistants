import java.util.*;

class Solution {
    public int[] rearrangeBarcodes(int[] barcodes) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int barcode : barcodes) {
            counts.put(barcode, counts.getOrDefault(barcode, 0) + 1);
        }

        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> counts.get(b) - counts.get(a));
        pq.addAll(counts.keySet());

        int[] result = new int[barcodes.length];
        int index = 0;
        while (!pq.isEmpty()) {
            int barcode = pq.poll();
            int count = counts.get(barcode);
            for (int i = 0; i < count; i++) {
                result[index] = barcode;
                index = (index + 2) % barcodes.length;
                if (index <= 0 && i < count - 1) {
                    index = 1;
                }
            }
        }

        return result;
    }
}