import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public int findMaximumNumberofElementsInSubset(int[] nums) {
        Map<Long, Integer> counts = new HashMap<>();
        for (int num : nums) {
            counts.put((long) num, counts.getOrDefault((long) num, 0) + 1);
        }

        int maxElements = 0;

        // Handle the special case of '1'.
        // If '1' is present, it can form a valid subset of any size (up to its frequency)
        // because 1*1 = 1, satisfying the condition.
        if (counts.containsKey(1L)) {
            maxElements = counts.get(1L);
        }

        Set<Long> visited = new HashSet<>();
        // Mark '1' as visited to prevent re-processing it in the main loop for other chains.
        // Its contribution is already accounted for.
        visited.add(1L); 

        for (long num : counts.keySet()) {
            // Skip '1' and numbers already part of a processed chain.
            if (visited.contains(num)) {
                continue;
            }

            long current = num;
            int currentChainLength = 0;
            long minFreqInChain = Long.MAX_VALUE;

            // Traverse the chain: x, x^2, x^4, x^8, ...
            // Each 'current' value must be present in 'nums' to extend the chain.
            while (counts.containsKey(current)) {
                visited.add(current); // Mark current number as visited
                minFreqInChain = Math.min(minFreqInChain, counts.get(current));
                currentChainLength++;

                // Optimization: If 'current' is greater than sqrt(10^9),
                // then 'current * current' will be greater than 10^9 (the maximum value in nums).
                // Thus, 'current * current' cannot be in 'nums', and the chain must end here.
                // 31622 is floor(sqrt(1_000_000_000)).
                if (current > 31622L) { 
                    break;
                }

                current *= current;
            }

            // For any number x > 1, if x is in the subset 's', then x*x must also be in 's'.
            // This implies that a valid chain must have at least two distinct elements (x and x*x).
            // If currentChainLength is 1, it means 'num' is present but 'num*num' is not in 'nums',
            // so 'num' cannot be included in 's'.
            if (currentChainLength >= 2) {
                // The total number of elements for this chain is (number of distinct elements in chain)
                // multiplied by (the minimum frequency of any element in that chain).
                // We take the maximum of this value and the previously found 'maxElements'.
                maxElements = Math.max(maxElements, currentChainLength * (int)minFreqInChain);
            }
        }

        return maxElements;
    }
}