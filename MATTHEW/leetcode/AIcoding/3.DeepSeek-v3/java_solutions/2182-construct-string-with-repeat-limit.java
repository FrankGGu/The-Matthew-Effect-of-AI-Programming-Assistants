class Solution {
    public String repeatLimitedString(String s, int repeatLimit) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        StringBuilder sb = new StringBuilder();
        int last = -1;
        while (true) {
            int max = -1;
            for (int i = 25; i >= 0; i--) {
                if (count[i] > 0 && i != last) {
                    max = i;
                    break;
                }
            }
            if (max == -1) break;
            int use = Math.min(count[max], max == last ? 1 : repeatLimit);
            for (int i = 0; i < use; i++) {
                sb.append((char)('a' + max));
            }
            count[max] -= use;
            last = max;
            if (count[max] > 0) {
                int next = -1;
                for (int i = max - 1; i >= 0; i--) {
                    if (count[i] > 0) {
                        next = i;
                        break;
                    }
                }
                if (next == -1) break;
                sb.append((char)('a' + next));
                count[next]--;
                last = next;
            }
        }
        return sb.toString();
    }
}