import java.util.*;

class Solution {
    public String repeatLimitedString(String s, int repeatLimit) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        StringBuilder result = new StringBuilder();

        while (true) {
            int index = -1;
            for (int i = 25; i >= 0; i--) {
                if (count[i] > 0) {
                    index = i;
                    break;
                }
            }
            if (index == -1) break;

            int toAdd = Math.min(count[index], repeatLimit);
            for (int i = 0; i < toAdd; i++) {
                result.append((char) (index + 'a'));
            }
            count[index] -= toAdd;

            if (count[index] > 0) {
                int nextIndex = -1;
                for (int i = index - 1; i >= 0; i--) {
                    if (count[i] > 0) {
                        nextIndex = i;
                        break;
                    }
                }
                if (nextIndex == -1) break;
                result.append((char) (nextIndex + 'a'));
                count[nextIndex]--;
            }
        }

        return result.toString();
    }
}