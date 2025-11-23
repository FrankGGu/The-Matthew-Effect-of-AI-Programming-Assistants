import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;

class Solution {
    public int[] rearrangeBarcodes(int[] barcodes) {
        if (barcodes == null || barcodes.length <= 1) {
            return barcodes;
        }

        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int barcode : barcodes) {
            freqMap.put(barcode, freqMap.getOrDefault(barcode, 0) + 1);
        }

        List<Map.Entry<Integer, Integer>> sortedEntries = new ArrayList<>(freqMap.entrySet());

        Collections.sort(sortedEntries, (a, b) -> b.getValue() - a.getValue());

        int[] result = new int[barcodes.length];
        int resultIdx = 0;

        for (Map.Entry<Integer, Integer> entry : sortedEntries) {
            int barcode = entry.getKey();
            int count = entry.getValue();

            while (count > 0) {
                result[resultIdx] = barcode;
                resultIdx += 2;
                count--;

                if (resultIdx >= barcodes.length) {
                    resultIdx = 1; 
                }
            }
        }

        return result;
    }
}