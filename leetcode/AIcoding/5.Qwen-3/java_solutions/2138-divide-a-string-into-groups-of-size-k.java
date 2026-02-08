public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> divideString(String s, int k) {
        List<String> result = new ArrayList<>();
        int n = s.length();
        for (int i = 0; i < n; i += k) {
            int end = Math.min(i + k, n);
            result.add(s.substring(i, end));
        }
        return result;
    }
}
}