public class Solution {

import java.util.*;

public class Solution {
    public List<String> findRepeatedDnaSequences(String s) {
        Set<String> seen = new HashSet<>();
        Set<String> result = new HashSet<>();

        for (int i = 0; i + 9 < s.length(); i++) {
            String sequence = s.substring(i, i + 10);
            if (seen.contains(sequence)) {
                result.add(sequence);
            } else {
                seen.add(sequence);
            }
        }

        return new ArrayList<>(result);
    }
}
}