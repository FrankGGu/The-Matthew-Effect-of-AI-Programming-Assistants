import java.util.LinkedList;
import java.util.Queue;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public String findLexSmallestString(String s, int a, int b) {
        String minString = s;
        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();

        queue.offer(s);
        visited.add(s);

        while (!queue.isEmpty()) {
            String currentString = queue.poll();

            if (currentString.compareTo(minString) < 0) {
                minString = currentString;
            }

            char[] charsAdd = currentString.toCharArray();
            for (int i = 1; i < charsAdd.length; i += 2) {
                charsAdd[i] = (char)(((charsAdd[i] - '0' + a) % 10) + '0');
            }
            String nextStringAdd = new String(charsAdd);

            if (!visited.contains(nextStringAdd)) {
                visited.add(nextStringAdd);
                queue.offer(nextStringAdd);
            }

            int n = currentString.length();
            String nextStringRotate = currentString.substring(n - b) + currentString.substring(0, n - b);

            if (!visited.contains(nextStringRotate)) {
                visited.add(nextStringRotate);
                queue.offer(nextStringRotate);
            }
        }

        return minString;
    }
}