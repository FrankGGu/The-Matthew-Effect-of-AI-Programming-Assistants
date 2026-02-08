class Solution {
    public String findLexSmallestString(String s, int a, int b) {
        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        String smallest = s;
        queue.offer(s);
        visited.add(s);

        while (!queue.isEmpty()) {
            String current = queue.poll();
            if (current.compareTo(smallest) < 0) {
                smallest = current;
            }

            String addStr = addOperation(current, a);
            if (!visited.contains(addStr)) {
                visited.add(addStr);
                queue.offer(addStr);
            }

            String rotateStr = rotateOperation(current, b);
            if (!visited.contains(rotateStr)) {
                visited.add(rotateStr);
                queue.offer(rotateStr);
            }
        }

        return smallest;
    }

    private String addOperation(String s, int a) {
        char[] chars = s.toCharArray();
        for (int i = 1; i < chars.length; i += 2) {
            int num = chars[i] - '0';
            num = (num + a) % 10;
            chars[i] = (char) (num + '0');
        }
        return new String(chars);
    }

    private String rotateOperation(String s, int b) {
        int n = s.length();
        b = b % n;
        return s.substring(n - b) + s.substring(0, n - b);
    }
}