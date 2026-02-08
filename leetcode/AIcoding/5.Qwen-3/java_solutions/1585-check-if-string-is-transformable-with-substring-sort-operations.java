public class Solution {

import java.util.*;

public class Solution {
    public boolean isTransformable(String s, String t) {
        int n = s.length();
        if (n != t.length()) return false;

        List<Deque<Integer>> pos = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            pos.add(new LinkedList<>());
        }

        for (int i = 0; i < n; i++) {
            pos.get(s.charAt(i) - '0').addLast(i);
        }

        for (int i = 0; i < n; i++) {
            int d = t.charAt(i) - '0';
            if (pos.get(d).isEmpty()) return false;
            int idx = pos.get(d).peekFirst();
            for (int j = 0; j < d; j++) {
                if (!pos.get(j).isEmpty() && pos.get(j).peekFirst() < idx) {
                    return false;
                }
            }
            pos.get(d).pollFirst();
        }

        return true;
    }
}
}