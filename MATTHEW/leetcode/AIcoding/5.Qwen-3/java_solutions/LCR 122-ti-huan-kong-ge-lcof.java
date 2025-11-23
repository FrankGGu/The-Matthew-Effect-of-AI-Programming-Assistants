public class Solution {

import java.util.*;

public class Solution {
    public String encode(String s, int[][] queries) {
        int n = s.length();
        List<String> result = new ArrayList<>();

        for (int[] query : queries) {
            int l = query[0];
            int r = query[1];
            StringBuilder path = new StringBuilder();
            Set<Character> visited = new HashSet<>();
            int i = l;
            while (i <= r) {
                char c = s.charAt(i);
                if (!visited.contains(c)) {
                    path.append(c);
                    visited.add(c);
                }
                i++;
            }
            result.add(path.toString());
        }

        return String.join(",", result);
    }
}
}