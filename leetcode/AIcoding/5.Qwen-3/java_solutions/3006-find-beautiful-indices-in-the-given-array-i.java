public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findBeautifulIndices(String s, int k) {
        List<Integer> result = new ArrayList<>();
        int n = s.length();
        for (int i = 0; i < n; i++) {
            boolean found = false;
            for (int j = 0; j < n; j++) {
                if (i != j && Math.abs(i - j) <= k && s.charAt(i) == s.charAt(j)) {
                    found = true;
                    break;
                }
            }
            if (found) {
                result.add(i);
            }
        }
        return result;
    }
}
}