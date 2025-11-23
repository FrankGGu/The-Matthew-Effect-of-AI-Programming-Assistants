public class Solution {

import java.util.*;

public class Solution {
    public int numMatchingSubseq(String s, String[] words) {
        Map<Character, List<String>> map = new HashMap<>();
        for (char c = 'a'; c <= 'z'; c++) {
            map.put(c, new ArrayList<>());
        }
        for (String word : words) {
            map.get(word.charAt(0)).add(word);
        }
        char[] sArray = s.toCharArray();
        for (int i = 0; i < sArray.length; i++) {
            char c = sArray[i];
            List<String> queue = map.get(c);
            List<String> nextQueue = new ArrayList<>();
            for (String word : queue) {
                if (word.length() == 1) {
                    ++count;
                } else {
                    nextQueue.add(word.substring(1));
                }
            }
            map.get(c).clear();
            for (String word : nextQueue) {
                map.get(word.charAt(0)).add(word);
            }
        }
        return count;
    }

    private int count = 0;
}
}