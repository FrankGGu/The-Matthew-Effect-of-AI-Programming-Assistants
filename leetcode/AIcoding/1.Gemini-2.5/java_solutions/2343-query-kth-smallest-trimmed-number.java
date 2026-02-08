import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.AbstractMap;

class Solution {
    public int[] smallestTrimmedNumbers(String[] nums, int[][] queries) {
        int numCount = nums.length;
        int maxLen = nums[0].length();
        int queryCount = queries.length;

        List<List<AbstractMap.SimpleEntry<String, Integer>>> precomputedSortedLists = new ArrayList<>(maxLen + 1);
        for (int i = 0; i <= maxLen; i++) {
            precomputedSortedLists.add(null);
        }

        for (int trim = 1; trim <= maxLen; trim++) {
            List<AbstractMap.SimpleEntry<String, Integer>> currentTrimList = new ArrayList<>(numCount);
            for (int i = 0; i < numCount; i++) {
                String num = nums[i];
                String trimmed = num.substring(num.length() - trim);
                currentTrimList.add(new AbstractMap.SimpleEntry<>(trimmed, i));
            }

            Collections.sort(currentTrimList, (a, b) -> {
                int cmp = a.getKey().compareTo(b.getKey());
                if (cmp == 0) {
                    return a.getValue().compareTo(b.getValue());
                }
                return cmp;
            });
            precomputedSortedLists.set(trim, currentTrimList);
        }

        int[] results = new int[queryCount];
        for (int j = 0; j < queryCount; j++) {
            int k = queries[j][0];
            int trim = queries[j][1];

            List<AbstractMap.SimpleEntry<String, Integer>> sortedList = precomputedSortedLists.get(trim);

            results[j] = sortedList.get(k - 1).getValue();
        }

        return results;
    }
}