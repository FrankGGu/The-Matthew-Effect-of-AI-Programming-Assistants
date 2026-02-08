class Solution {
    public boolean isTransformable(String s, String t) {
        if (s.length() != t.length()) return false;
        int n = s.length();
        Deque<Integer>[] pos = new Deque[10];
        for (int i = 0; i < 10; i++) {
            pos[i] = new ArrayDeque<>();
        }
        for (int i = 0; i < n; i++) {
            pos[s.charAt(i) - '0'].add(i);
        }
        for (int i = 0; i < n; i++) {
            int digit = t.charAt(i) - '0';
            if (pos[digit].isEmpty()) {
                return false;
            }
            for (int d = 0; d < digit; d++) {
                if (!pos[d].isEmpty() && pos[d].peek() < pos[digit].peek()) {
                    return false;
                }
            }
            pos[digit].poll();
        }
        return true;
    }
}