public class Solution {

import java.util.*;

public class Solution {
    public String reorganizeString(String s) {
        Map<Character, Integer> freq = new HashMap<>();
        for (char c : s.toCharArray()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }

        PriorityQueue<int[]> maxHeap = new PriorityQueue<>((a, b) -> b[1] - a[1]);
        for (Map.Entry<Character, Integer> entry : freq.entrySet()) {
            maxHeap.offer(new int[] { entry.getKey(), entry.getValue() });
        }

        StringBuilder result = new StringBuilder();
        char prevChar = '\0';
        int prevCount = 0;

        while (!maxHeap.isEmpty()) {
            int[] curr = maxHeap.poll();
            result.append((char) curr[0]);
            curr[1]--;
            if (prevCount > 0) {
                maxHeap.offer(new int[] { prevChar, prevCount });
            }
            prevChar = (char) curr[0];
            prevCount = curr[1];
        }

        if (result.length() != s.length()) {
            return "";
        }

        return result.toString();
    }
}
}