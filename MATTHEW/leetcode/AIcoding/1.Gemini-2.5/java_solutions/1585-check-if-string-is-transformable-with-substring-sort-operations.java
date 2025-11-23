import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public boolean isTransformable(String s, String t) {
        if (s.length() != t.length()) {
            return false;
        }

        int[] sCounts = new int[10];
        int[] tCounts = new int[10];
        for (char c : s.toCharArray()) {
            sCounts[c - '0']++;
        }
        for (char c : t.toCharArray()) {
            tCounts[c - '0']++;
        }
        for (int i = 0; i < 10; i++) {
            if (sCounts[i] != tCounts[i]) {
                return false;
            }
        }

        Queue<Integer>[] sIndices = new Queue[10];
        for (int i = 0; i < 10; i++) {
            sIndices[i] = new LinkedList<>();
        }
        for (int i = 0; i < s.length(); i++) {
            sIndices[s.charAt(i) - '0'].offer(i);
        }

        for (int i = 0; i < t.length(); i++) {
            int targetDigit = t.charAt(i) - '0';

            int currentSIdx = sIndices[targetDigit].peek();

            for (int dSmaller = 0; dSmaller < targetDigit; dSmaller++) {
                if (!sIndices[dSmaller].isEmpty() && sIndices[dSmaller].peek() < currentSIdx) {
                    return false;
                }
            }

            sIndices[targetDigit].poll();
        }

        return true;
    }
}