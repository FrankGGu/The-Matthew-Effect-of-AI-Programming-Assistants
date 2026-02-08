public class Solution {

import java.util.*;

public class Solution {
    public boolean reportSpam(String message, String[] bannedWords, int k) {
        Set<String> bannedSet = new HashSet<>(Arrays.asList(bannedWords));
        int count = 0;
        for (char c : message.toCharArray()) {
            String word = String.valueOf(c);
            if (bannedSet.contains(word)) {
                count++;
                if (count >= k) {
                    return true;
                }
            }
        }
        return false;
    }
}
}