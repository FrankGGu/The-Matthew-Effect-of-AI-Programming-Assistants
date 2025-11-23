import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;
import java.util.HashSet;

class Solution {
    public int kSimilarity(String s1, String s2) {
        if (s1.equals(s2)) {
            return 0;
        }

        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();

        queue.offer(s1);
        visited.add(s1);

        int swaps = 0;

        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            for (int k = 0; k < levelSize; k++) {
                String current = queue.poll();

                if (current.equals(s2)) {
                    return swaps;
                }

                int i = 0;
                while (i < current.length() && current.charAt(i) == s2.charAt(i)) {
                    i++;
                }

                for (int j = i + 1; j < current.length(); j++) {
                    if (current.charAt(j) == s2.charAt(i) && current.charAt(j) != s2.charAt(j)) {
                        String next = swap(current, i, j);
                        if (!visited.contains(next)) {
                            visited.add(next);
                            queue.offer(next);
                        }
                    }
                }
            }
            swaps++;
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