public class Solution {

import java.util.*;

public class Solution {
    public int numSpecialEquivGroups(String[] A) {
        Set<String> set = new HashSet<>();
        for (String s : A) {
            char[] chars = s.toCharArray();
            Arrays.sort(chars);
            String sorted = new String(chars);
            set.add(sorted);
        }
        return set.size();
    }
}
}