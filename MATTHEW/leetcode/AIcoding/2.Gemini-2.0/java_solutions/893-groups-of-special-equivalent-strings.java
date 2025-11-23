import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numSpecialEquivGroups(String[] A) {
        Set<String> seen = new HashSet<>();
        for (String s : A) {
            int[] even = new int[26];
            int[] odd = new int[26];
            for (int i = 0; i < s.length(); i++) {
                if (i % 2 == 0) {
                    even[s.charAt(i) - 'a']++;
                } else {
                    odd[s.charAt(i) - 'a']++;
                }
            }
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < 26; i++) {
                sb.append(even[i]);
                sb.append(",");
            }
            for (int i = 0; i < 26; i++) {
                sb.append(odd[i]);
                sb.append(",");
            }
            seen.add(sb.toString());
        }
        return seen.size();
    }
}