class Solution {
    public String findLexSmallestString(String s, int a, int b) {
        String minString = s;
        int n = s.length();
        boolean[] visited = new boolean[n];
        Queue<String> queue = new LinkedList<>();
        queue.offer(s);
        visited[0] = true;

        while (!queue.isEmpty()) {
            String current = queue.poll();
            if (current.compareTo(minString) < 0) {
                minString = current;
            }
            String incremented = increment(current, a);
            if (!visited[0]) {
                queue.offer(incremented);
                visited[0] = true;
            }
            String rotated = rotate(current, b);
            if (!visited[1]) {
                queue.offer(rotated);
                visited[1] = true;
            }
        }

        return minString;
    }

    private String increment(String s, int a) {
        char[] arr = s.toCharArray();
        for (int i = 0; i < arr.length; i++) {
            arr[i] = (char) ((arr[i] - '0' + a) % 10 + '0');
        }
        return new String(arr);
    }

    private String rotate(String s, int b) {
        int n = s.length();
        b = b % n;
        return s.substring(n - b) + s.substring(0, n - b);
    }
}