public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int echoSubstrings(String s) {
        int n = s.length();
        Set<String> seen = new HashSet<>();
        Set<String> result = new HashSet<>();

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int len = j - i;
                if (i + len <= n && j + len <= n) {
                    String a = s.substring(i, i + len);
                    String b = s.substring(j, j + len);
                    if (a.equals(b)) {
                        result.add(a);
                    }
                }
            }
        }

        return result.size();
    }
}
}