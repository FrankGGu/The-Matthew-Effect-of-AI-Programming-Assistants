public class Solution {

import java.util.*;

public class Solution {
    public String minimumString(String a, String b, String c) {
        List<String> candidates = new ArrayList<>();
        candidates.add(a + b + c);
        candidates.add(a + c + b);
        candidates.add(b + a + c);
        candidates.add(b + c + a);
        candidates.add(c + a + b);
        candidates.add(c + b + a);

        Set<String> all = new HashSet<>();
        all.add(a);
        all.add(b);
        all.add(c);

        for (int i = 0; i < 6; i++) {
            String s = candidates.get(i);
            Set<String> set = new HashSet<>();
            set.add(a);
            set.add(b);
            set.add(c);
            String temp = "";
            int index = 0;
            for (int j = 0; j < s.length(); j++) {
                if (index < 3 && s.charAt(j) == all.toArray()[index].charAt(0)) {
                    temp += s.charAt(j);
                    index++;
                }
            }
            if (index == 3) {
                candidates.set(i, temp);
            }
        }

        Collections.sort(candidates, (x, y) -> {
            if (x.length() != y.length()) return x.length() - y.length();
            return x.compareTo(y);
        });

        return candidates.get(0);
    }
}
}