import java.util.HashSet;
import java.util.Set;

public class Solution {
    public String longestCommonPrefix(String[] strs, int k) {
        if (strs == null || strs.length == 0 || k > strs.length) return "";

        StringBuilder prefix = new StringBuilder();
        for (int i = 0; i < strs[0].length(); i++) {
            char current = strs[0].charAt(i);
            int count = 0;
            for (String str : strs) {
                if (i < str.length() && str.charAt(i) == current) {
                    count++;
                }
            }
            if (count >= k) {
                prefix.append(current);
            } else {
                break;
            }
        }
        return prefix.toString();
    }
}