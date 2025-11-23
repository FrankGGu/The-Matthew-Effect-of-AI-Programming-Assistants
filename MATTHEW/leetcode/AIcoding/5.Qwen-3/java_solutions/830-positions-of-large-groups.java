public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> largeGroupPositions(String s) {
        List<List<Integer>> result = new ArrayList<>();
        int n = s.length();
        int start = 0;

        for (int i = 1; i < n; i++) {
            if (s.charAt(i) != s.charAt(i - 1)) {
                if (i - start >= 3) {
                    List<Integer> group = new ArrayList<>();
                    group.add(start);
                    group.add(i - 1);
                    result.add(group);
                }
                start = i;
            }
        }

        if (n - start >= 3) {
            List<Integer> group = new ArrayList<>();
            group.add(start);
            group.add(n - 1);
            result.add(group);
        }

        return result;
    }
}
}