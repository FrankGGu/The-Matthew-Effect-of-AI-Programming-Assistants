public class Solution {

import java.util.*;

public class Solution {
    public String repeatLimitedString(int[] repeatLimits, String s) {
        PriorityQueue<char[]> pq = new PriorityQueue<>((a, b) -> b[0] - a[0]);
        Map<Character, Integer> count = new HashMap<>();

        for (char c : s.toCharArray()) {
            count.put(c, count.getOrDefault(c, 0) + 1);
        }

        for (char c : count.keySet()) {
            pq.offer(new char[]{c, (byte) repeatLimits[c - 'a']});
        }

        StringBuilder result = new StringBuilder();

        while (!pq.isEmpty()) {
            char[] first = pq.poll();
            int used = Math.min(count.get(first[0]), first[1]);
            for (int i = 0; i < used; i++) {
                result.append(first[0]);
            }
            count.put(first[0], count.get(first[0]) - used);

            if (count.get(first[0]) > 0) {
                pq.offer(first);
            }

            if (!pq.isEmpty()) {
                char[] second = pq.poll();
                int usedSecond = Math.min(count.get(second[0]), second[1]);
                for (int i = 0; i < usedSecond; i++) {
                    result.append(second[0]);
                }
                count.put(second[0], count.get(second[0]) - usedSecond);

                if (count.get(second[0]) > 0) {
                    pq.offer(second);
                }
            }
        }

        return result.toString();
    }
}
}