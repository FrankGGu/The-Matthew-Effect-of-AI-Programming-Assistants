class Solution {
    public String findLexSmallestString(String s, int a, int b) {
        int n = s.length();
        boolean[] visited = new boolean[n];
        String result = s;
        Queue<String> queue = new LinkedList<>();
        queue.add(s);

        while (!queue.isEmpty()) {
            String current = queue.poll();
            if (current.compareTo(result) < 0) {
                result = current;
            }
            for (int i = 0; i < n; i++) {
                // Operation 1: Add 'a'
                StringBuilder sb = new StringBuilder(current);
                sb.setCharAt(i, (char) ((current.charAt(i) - '0' + a) % 10 + '0'));
                String next1 = sb.toString();
                if (!visited[i] || next1.compareTo(current) < 0) {
                    visited[i] = true;
                    queue.add(next1);
                }
            }
            // Operation 2: Rotate
            String next2 = current.substring(n - b) + current.substring(0, n - b);
            if (!visited[n - b]) {
                visited[n - b] = true;
                queue.add(next2);
            }
        }

        return result;
    }
}