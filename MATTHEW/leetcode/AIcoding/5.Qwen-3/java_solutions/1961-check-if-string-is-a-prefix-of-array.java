public class Solution {

import java.util.*;

public class Solution {
    public boolean isPrefixString(String[] words, String s) {
        StringBuilder sb = new StringBuilder();
        for (String word : words) {
            sb.append(word);
            if (sb.toString().equals(s)) {
                return true;
            }
        }
        return false;
    }
}
}