import java.util.*;

class Solution {
    public int[] recoverArray(int[] sums) {
        int n = (int) (Math.log(sums.length) / Math.log(2));
        int[] ans = new int[n];

        // Sort the sums array to easily find the smallest difference
        Arrays.sort(sums);

        // Use a TreeMap to keep track of sums and their counts.
        // TreeMap keeps keys sorted, which is crucial for finding min/max and iterating.
        TreeMap<Integer, Integer> currentSumsMap = new TreeMap<>();
        for (int sum : sums) {
            currentSumsMap.put(sum, currentSumsMap.getOrDefault(sum, 0) + 1);
        }

        // Iterate n times to find n elements of the original array
        for (int i = 0; i < n; i++) {
            // The smallest non-zero difference between two sums in the current set
            // is a candidate for the absolute value of an element in the original array.
            // This is effectively `sums[1] - sums[0]` if `sums` were an array.
            int x = currentSumsMap.keySet().stream().skip(1).findFirst().get() - currentSumsMap.firstKey();

            // Build nextSumsMap by removing pairs (s, s+x)
            // This process assumes `x` is positive.
            TreeMap<Integer, Integer> nextSumsMap = new TreeMap<>();
            TreeMap<Integer, Integer> tempMap = new TreeMap<>(currentSumsMap);

            int count = 0;
            int targetSize = 1 << (n - i - 1); // Number of sums for the next iteration
            while (count < targetSize) {
                int s = tempMap.firstKey();

                nextSumsMap.put(s, nextSumsMap.getOrDefault(s, 0) + 1);

                // Decrement count for s
                tempMap.put(s, tempMap.get(s) - 1);
                if (tempMap.get(s) == 0) {
                    tempMap.remove(s);
                }

                // Decrement count for s+x
                int sPlusX = s + x;
                tempMap.put(sPlusX, tempMap.get(sPlusX) - 1);
                if (tempMap.get(sPlusX) == 0) {
                    tempMap.remove(sPlusX);
                }
                count++;
            }

            // Determine the sign of x
            // If the smallest sum in the newly formed set (nextSumsMap) is not 0,
            // it means that the element we just extracted (`x`) must have been negative.
            // This is because if `x` was positive, the smallest sum of the remaining elements
            // would be the same as the smallest sum of the current set (if the original array
            // contained negative numbers), or 0 (if all elements were non-negative).
            // If `nextSumsMap.firstKey()` is not 0, it means the `x` we assumed to be positive
            // actually corresponds to a negative number being removed.
            if (nextSumsMap.firstKey() != 0) {
                ans[i] = -x;
                // If x was negative, the `nextSumsMap` (which was built assuming `x` was positive)
                // actually represents `S_prime - |x|`.
                // To get `S_prime` (the correct set of sums for the remaining elements),
                // we need to shift all elements in `nextSumsMap` by `|x|`.
                // Since `ans[i]` is `-x`, we add `x` to each element.
                TreeMap<Integer, Integer> shiftedNextSumsMap = new TreeMap<>();
                for (Map.Entry<Integer, Integer> entry : nextSumsMap.entrySet()) {
                    shiftedNextSumsMap.put(entry.getKey() + x, entry.getValue());
                }
                currentSumsMap = shiftedNextSumsMap;
            } else {
                ans[i] = x;
                currentSumsMap = nextSumsMap;
            }
        }

        return ans;
    }
}