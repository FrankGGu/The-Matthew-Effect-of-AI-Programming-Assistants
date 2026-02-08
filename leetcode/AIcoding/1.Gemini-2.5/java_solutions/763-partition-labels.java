import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> partitionLabels(String s) {
        int[] lastPos = new int[26];
        for (int i = 0; i < s.length(); i++) {
            lastPos[s.charAt(i) - 'a'] = i;
        }

        List<Integer> result = new ArrayList<>();
        int start = 0;
        int maxReach = 0;

        for (int i = 0; i < s.length(); i++) {
            maxReach = Math.max(maxReach, lastPos[s.charAt(i) - 'a']);
            if (i == maxReach) {
                result.add(i - start + 1);
                start = i + 1;
            }
        }

        return result;
    }
}