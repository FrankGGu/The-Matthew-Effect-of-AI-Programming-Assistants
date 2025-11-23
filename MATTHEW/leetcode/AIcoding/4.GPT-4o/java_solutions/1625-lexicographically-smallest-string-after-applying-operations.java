class Solution {
    public String findLexSmallestString(String s, int a, int b) {
        int n = s.length();
        boolean[] visited = new boolean[n];
        String result = s;
        Queue<String> queue = new LinkedList<>();
        queue.offer(s);
        visited[0] = true;

        while (!queue.isEmpty()) {
            String current = queue.poll();
            result = result.compareTo(current) < 0 ? result : current;

            String rotated = rotate(current, b);
            if (!visited[rotated.hashCode() % n]) {
                visited[rotated.hashCode() % n] = true;
                queue.offer(rotated);
            }

            String incremented = increment(current, a);
            if (!visited[incremented.hashCode() % n]) {
                visited[incremented.hashCode() % n] = true;
                queue.offer(incremented);
            }
        }

        return result;
    }

    private String rotate(String s, int b) {
        int n = s.length();
        b %= n;
        return s.substring(n - b) + s.substring(0, n - b);
    }

    private String increment(String s, int a) {
        char[] chars = s.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            chars[i] = (char) ((chars[i] - '0' + a) % 10 + '0');
        }
        return new String(chars);
    }
}