import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;

class Solution {
    public int kSimilarity(String s1, String s2) {
        if (s1.equals(s2)) {
            return 0;
        }

        Queue<String> queue = new LinkedList<>();
        queue.offer(s1);

        Set<String> visited = new HashSet<>();
        visited.add(s1);

        int level = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();

                if (current.equals(s2)) {
                    return level;
                }

                for (String neighbor : getNeighbors(current, s2)) {
                    if (!visited.contains(neighbor)) {
                        queue.offer(neighbor);
                        visited.add(neighbor);
                    }
                }
            }
            level++;
        }

        return -1;
    }

    private Set<String> getNeighbors(String s1, String s2) {
        Set<String> neighbors = new HashSet<>();
        int n = s1.length();

        int i = 0;
        while (i < n && s1.charAt(i) == s2.charAt(i)) {
            i++;
        }

        for (int j = i + 1; j < n; j++) {
            if (s1.charAt(j) == s2.charAt(i) && s1.charAt(j) != s2.charAt(j)) {
                String neighbor = swap(s1, i, j);
                neighbors.add(neighbor);
            }
        }

        return neighbors;
    }

    private String swap(String s, int i, int j) {
        char[] arr = s.toCharArray();
        char temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
        return new String(arr);
    }
}