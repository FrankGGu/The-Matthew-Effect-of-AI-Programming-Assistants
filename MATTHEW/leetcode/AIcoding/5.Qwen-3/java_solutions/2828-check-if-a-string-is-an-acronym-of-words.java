public class Solution {

import java.util.*;

public class Solution {
    public boolean isAcronym(String[] words, String s) {
        if (words.length != s.length()) {
            return false;
        }
        for (int i = 0; i < words.length; i++) {
            if (words[i].charAt(0) != s.charAt(i)) {
                return false;
            }
        }
        return true;
    }
}
}