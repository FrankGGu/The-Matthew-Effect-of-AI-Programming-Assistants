public class Solution {

import java.util.*;

public class Solution {
    public int countDistinctStrings(String[] words) {
        Set<String> set = new HashSet<>();
        for (String word : words) {
            set.add(word);
        }
        return set.size();
    }
}
}