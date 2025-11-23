public class Solution {

import java.util.*;

public class Solution {
    public int kSimilarString(String s, String t) {
        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.add(s);
        visited.add(s);
        int result = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(t)) {
                    return result;
                }
                for (int j = 0; j < current.length(); j++) {
                    if (current.charAt(j) != t.charAt(j)) {
                        for (int k = j + 1; k < current.length(); k++) {
                            if (current.charAt(k) == t.charAt(j) && current.charAt(j) == t.charAt(k)) {
                                String next = swap(current, j, k);
                                if (!visited.contains(next)) {
                                    visited.add(next);
                                    queue.add(next);
                                }
                            }
                        }
                    }
                }
            }
            result++;
        }
        return -1;
    }

    private String swap(String s, int i, int j) {
        char[] chars = s.toCharArray();
        char temp = chars[i];
        chars[i] = chars[j];
        chars[j] = temp;
        return new String(chars);
    }
}
}