public class Solution {

import java.util.*;

public class Solution {
    public int[] findSubtreeSizes(int n, String s, int[][] queries) {
        Map<Character, List<Integer>> charToIndices = new HashMap<>();
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            charToIndices.putIfAbsent(c, new ArrayList<>());
            charToIndices.get(c).add(i);
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int index = queries[i][0];
            char newChar = (char) queries[i][1];
            char oldChar = s.charAt(index);
            if (oldChar == newChar) {
                result[i] = 0;
                continue;
            }

            List<Integer> oldList = charToIndices.get(oldChar);
            oldList.remove(Integer.valueOf(index));
            if (oldList.isEmpty()) {
                charToIndices.remove(oldChar);
            }

            charToIndices.putIfAbsent(newChar, new ArrayList<>());
            charToIndices.get(newChar).add(index);

            int count = 0;
            for (List<Integer> list : charToIndices.values()) {
                if (list.contains(index)) {
                    count = list.size();
                    break;
                }
            }
            result[i] = count;
        }

        return result;
    }
}
}