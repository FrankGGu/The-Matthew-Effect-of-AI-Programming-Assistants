import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int minOperations(int[] target, int[] arr) {
        Map<Integer, Integer> targetValToIndex = new HashMap<>();
        for (int i = 0; i < target.length; i++) {
            targetValToIndex.put(target[i], i);
        }

        List<Integer> effectiveArrIndices = new ArrayList<>();
        for (int num : arr) {
            if (targetValToIndex.containsKey(num)) {
                effectiveArrIndices.add(targetValToIndex.get(num));
            }
        }

        // Find the Longest Increasing Subsequence (LIS) of effectiveArrIndices
        List<Integer> tails = new ArrayList<>();
        for (int num : effectiveArrIndices) {
            int idx = Collections.binarySearch(tails, num);
            if (idx < 0) {
                int insertionPoint = -idx - 1;
                if (insertionPoint == tails.size()) {
                    tails.add(num);
                } else {
                    tails.set(insertionPoint, num);
                }
            }
            // If idx >= 0, num is already in tails, meaning it's already the smallest end
            // for some length. For a strictly increasing subsequence, we don't need to do anything.
        }

        int longestCommonSubsequenceLength = tails.size();
        return target.length - longestCommonSubsequenceLength;
    }
}