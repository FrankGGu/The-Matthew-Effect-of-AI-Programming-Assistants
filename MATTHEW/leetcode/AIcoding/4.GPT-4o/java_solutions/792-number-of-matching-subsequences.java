import java.util.*;

public class Solution {
    public int numMatchingSubseq(String s, String[] words) {
        Map<Character, List<Iterator<String>>> waiting = new HashMap<>();
        for (String word : words) {
            char firstChar = word.charAt(0);
            waiting.putIfAbsent(firstChar, new ArrayList<>());
            waiting.get(firstChar).add(word.iterator());
        }

        int count = 0;
        for (char c : s.toCharArray()) {
            List<Iterator<String>> iterators = waiting.get(c);
            if (iterators != null) {
                waiting.remove(c);
                for (Iterator<String> it : iterators) {
                    if (it.hasNext()) {
                        String word = it.next();
                        if (word.length() == 1) {
                            count++;
                        } else {
                            char nextChar = word.charAt(1);
                            waiting.putIfAbsent(nextChar, new ArrayList<>());
                            waiting.get(nextChar).add(it);
                        }
                    }
                }
            }
        }

        return count;
    }
}