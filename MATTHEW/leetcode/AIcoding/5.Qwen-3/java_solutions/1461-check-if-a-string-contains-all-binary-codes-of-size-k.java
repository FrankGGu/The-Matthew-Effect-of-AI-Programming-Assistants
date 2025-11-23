public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public boolean hasAllCodesOfSizeK(String s, int k) {
        Set<String> set = new HashSet<>();
        int n = s.length();
        for (int i = 0; i + k <= n; i++) {
            set.add(s.substring(i, i + k));
        }
        int required = 1 << k;
        return set.size() >= required;
    }
}
}