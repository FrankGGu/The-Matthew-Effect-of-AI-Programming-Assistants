class Solution {
    public int[] rearrangeBarcodes(int[] barcodes) {
        if (barcodes == null || barcodes.length == 0) {
            return new int[0];
        }

        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int barcode : barcodes) {
            freqMap.put(barcode, freqMap.getOrDefault(barcode, 0) + 1);
        }

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> freqMap.get(b) - freqMap.get(a));
        maxHeap.addAll(freqMap.keySet());

        int[] result = new int[barcodes.length];
        int index = 0;

        while (!maxHeap.isEmpty()) {
            int barcode = maxHeap.poll();
            int freq = freqMap.get(barcode);

            if (index == 0 || result[index - 1] != barcode) {
                result[index++] = barcode;
                freq--;
            } else {
                int nextBarcode = maxHeap.poll();
                result[index++] = nextBarcode;
                int nextFreq = freqMap.get(nextBarcode) - 1;
                freqMap.put(nextBarcode, nextFreq);
                if (nextFreq > 0) {
                    maxHeap.offer(nextBarcode);
                }
            }

            if (freq > 0) {
                freqMap.put(barcode, freq);
                maxHeap.offer(barcode);
            }
        }

        return result;
    }
}