public class Solution {

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Solution {
    public String[] findWords(String[] words) {
        Set<Character> row1 = new HashSet<>(List.of('q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'));
        Set<Character> row2 = new HashSet<>(List.of('a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'));
        Set<Character> row3 = new HashSet<>(List.of('z', 'x', 'c', 'v', 'b', 'n', 'm'));

        List<String> result = new ArrayList<>();

        for (String word : words) {
            boolean inRow1 = true;
            boolean inRow2 = true;
            boolean inRow3 = true;

            for (char c : word.toLowerCase().toCharArray()) {
                if (!row1.contains(c)) inRow1 = false;
                if (!row2.contains(c)) inRow2 = false;
                if (!row3.contains(c)) inRow3 = false;
            }

            if (inRow1 || inRow2 || inRow3) {
                result.add(word);
            }
        }

        return result.toArray(new String[0]);
    }
}
}