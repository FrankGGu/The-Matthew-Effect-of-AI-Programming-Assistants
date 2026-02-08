public class Solution {

import java.util.*;

public class Solution {
    public String encode(List<String> strs) {
        StringBuilder sb = new StringBuilder();
        for (String s : strs) {
            sb.append(s.length()).append('/').append(s);
        }
        return sb.toString();
    }

    public List<String> decode(String s) {
        List<String> result = new ArrayList<>();
        int i = 0;
        while (i < s.length()) {
            int slashIndex = s.indexOf('/', i);
            int length = Integer.parseInt(s.substring(i, slashIndex));
            i = slashIndex + 1;
            result.add(s.substring(i, i + length));
            i += length;
        }
        return result;
    }
}
}