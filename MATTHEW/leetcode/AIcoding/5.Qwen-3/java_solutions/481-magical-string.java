public class Solution {

import java.util.*;

public class Solution {
    public int magicalString(int n) {
        if (n == 0) return 0;
        if (n <= 3) return 1;

        List<Integer> s = new ArrayList<>();
        s.add(1);
        s.add(2);
        s.add(2);

        int i = 2;
        int next = 1;

        while (s.size() < n) {
            int count = s.get(i);
            for (int j = 0; j < count; j++) {
                s.add(next);
            }
            i++;
            next = 1 - next;
        }

        int result = 0;
        for (int j = 0; j < n; j++) {
            if (s.get(j) == 1) {
                result++;
            }
        }
        return result;
    }
}
}