import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public String makeLargestSpecial(String s) {
        if (s.isEmpty()) {
            return "";
        }

        List<String> specialSubstrings = new ArrayList<>();
        int balance = 0;
        int start = 0;

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                balance++;
            } else {
                balance--;
            }

            if (balance == 0) {
                // Found a special binary substring s[start...i]
                // The inner part is s.substring(start + 1, i)
                String innerSpecial = makeLargestSpecial(s.substring(start + 1, i));
                specialSubstrings.add("1" + innerSpecial + "0");
                start = i + 1;
            }
        }

        // Sort the collected special substrings in lexicographically descending order
        Collections.sort(specialSubstrings, Collections.reverseOrder());

        // Concatenate them to form the result
        StringBuilder sb = new StringBuilder();
        for (String str : specialSubstrings) {
            sb.append(str);
        }

        return sb.toString();
    }
}