public class Solution {

import java.util.*;

public class Solution {
    public List<String> commonChars(String[] A) {
        int[] common = new int[26];
        Arrays.fill(common, Integer.MAX_VALUE);

        for (String word : A) {
            int[] count = new int[26];
            for (char c : word.toCharArray()) {
                count[c - 'a']++;
            }
            for (int i = 0; i < 26; i++) {
                common[i] = Math.min(common[i], count[i]);
            }
        }

        List<String> result = new ArrayList<>();
        for (int i = 0; i < 26; i++) {
            while (common[i] > 0) {
                result.add(Character.toString((char) ('a' + i)));
                common[i]--;
            }
        }

        return result;
    }
}
}