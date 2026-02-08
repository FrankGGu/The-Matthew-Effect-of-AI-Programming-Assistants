public class Solution {

import java.util.*;

public class Solution {
    public int lengthLongestPath(String input) {
        Map<Integer, Integer> map = new HashMap<>();
        int maxLen = 0;
        String[] lines = input.split("\n");

        for (String line : lines) {
            int level = 0;
            while (line.startsWith("\t")) {
                level++;
                line = line.substring(1);
            }

            if (line.contains(".")) {
                int len = map.getOrDefault(level - 1, 0) + line.length();
                maxLen = Math.max(maxLen, len);
            } else {
                map.put(level, map.getOrDefault(level - 1, 0) + line.length());
            }
        }

        return maxLen;
    }
}
}