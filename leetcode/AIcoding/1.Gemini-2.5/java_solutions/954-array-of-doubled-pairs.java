import java.util.Map;
import java.util.TreeMap;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

class Solution {
    public boolean canReorderDoubled(int[] arr) {
        // Use a TreeMap to store frequencies. TreeMap keeps keys sorted,
        // which is useful for collecting unique numbers.
        TreeMap<Integer, Integer> counts = new TreeMap<>();
        for (int x : arr) {
            counts.put(x, counts.getOrDefault(x, 0) + 1);
        }

        // Collect all unique numbers (keys) into a list.
        ArrayList<Integer> keys = new ArrayList<>(counts.keySet());

        // Sort the keys based on their absolute values in ascending order.
        // This sorting strategy is crucial:
        // - For positive numbers (e.g., 1, 2, 4): 1 is processed before 2, 2 before 4.
        //   So, when processing 'x', '2x' will either be available or processed later.
        // - For negative numbers (e.g., -2, -4): |-2| < |-4|, so -2 is processed before -4.
        //   When processing 'x' (e.g., -2), '2x' (e.g., -4) will be available (as it's processed later).
        // This ensures that for any pair (x, 2x), 'x' is always processed before '2x'.
        Collections.sort(keys, (a, b) -> Integer.compare(Math.abs(a), Math.abs(b)));

        for (int num : keys) {
            int freq = counts.get(num);
            if (freq == 0) {
                // This number has already been paired up (its count reduced to 0)
                continue;
            }

            // Handle zero separately: zeros must pair with other zeros.
            // So, the count of zeros must be even.
            if (num == 0) {
                if (freq % 2 != 0) {
                    return false; // Odd number of zeros, cannot all be paired
                }
                // All zeros are now considered paired.
                counts.put(0, 0); 
                continue;
            }

            // For any non-zero number 'num', we need to find '2 * num' to form a pair.
            int targetPair = num * 2;
            int targetPairFreq = counts.getOrDefault(targetPair, 0);

            if (targetPairFreq < freq) {
                // Not enough 'targetPair' numbers available to match all 'num' numbers.
                return false;
            }

            // If enough 'targetPair' numbers are found, decrement their count.
            counts.put(targetPair, targetPairFreq - freq);
            // All instances of 'num' are now considered paired, so set its count to 0.
            counts.put(num, 0); 
        }

        // If all numbers could be successfully paired, return true.
        return true;
    }
}