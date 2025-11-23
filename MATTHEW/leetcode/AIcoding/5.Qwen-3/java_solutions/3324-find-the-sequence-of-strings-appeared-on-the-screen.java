public class Solution {

import java.util.*;

public class Solution {
    public List<String> stringSequence(int n) {
        List<String> result = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            StringBuilder sb = new StringBuilder();
            for (int j = 0; j < i; j++) {
                sb.append((char) ('a' + j));
            }
            result.add(sb.toString());
        }
        return result;
    }
}
}