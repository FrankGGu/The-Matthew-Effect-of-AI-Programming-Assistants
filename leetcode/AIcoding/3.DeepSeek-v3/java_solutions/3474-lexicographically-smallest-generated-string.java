class Solution {
    public String findLexSmallestString(String s, int a, int b) {
        String res = s;
        int n = s.length();
        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.offer(s);
        visited.add(s);

        while (!queue.isEmpty()) {
            String current = queue.poll();
            if (current.compareTo(res) < 0) {
                res = current;
            }

            // Operation 1: Add a to odd indices
            char[] arr = current.toCharArray();
            for (int i = 1; i < n; i += 2) {
                arr[i] = (char)(((arr[i] - '0' + a) % 10) + '0');
            }
            String op1 = new String(arr);
            if (!visited.contains(op1)) {
                visited.add(op1);
                queue.offer(op1);
            }

            // Operation 2: Rotate right by b positions
            String op2 = current.substring(n - b) + current.substring(0, n - b);
            if (!visited.contains(op2)) {
                visited.add(op2);
                queue.offer(op2);
            }
        }

        return res;
    }
}