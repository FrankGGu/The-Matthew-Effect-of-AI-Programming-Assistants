public class Solution {

import java.util.*;

public class Solution {
    public int countVowelSubstrings(String s) {
        int count = 0;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            Set<Character> vowels = new HashSet<>();
            for (int j = i; j < n; j++) {
                char c = s.charAt(j);
                if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                    vowels.add(c);
                    if (vowels.size() == 5) {
                        count++;
                    }
                } else {
                    break;
                }
            }
        }
        return count;
    }
}
}