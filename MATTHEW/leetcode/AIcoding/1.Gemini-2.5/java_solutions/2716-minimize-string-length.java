import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minimizeStringLength(String s) {
        Set<Character> distinctChars = new HashSet<>();
        for (char c : s.toCharArray()) {
            distinctChars.add(c);
        }
        return distinctChars.size();
    }
}