public class Solution {

import java.util.*;

public class Solution {
    public boolean isAdditiveNumber(String num) {
        int n = num.length();
        for (int i = 1; i < n; i++) {
            if (num.charAt(0) == '0' && i > 1) break;
            long first = Long.parseLong(num.substring(0, i));
            for (int j = i + 1; j < n; j++) {
                if (num.charAt(i) == '0' && j > i + 1) break;
                long second = Long.parseLong(num.substring(i, j));
                if (dfs(num, j, first, second)) return true;
            }
        }
        return false;
    }

    private boolean dfs(String num, int start, long first, long second) {
        if (start == num.length()) return true;
        long sum = first + second;
        String s = String.valueOf(sum);
        if (num.startsWith(s, start)) {
            return dfs(num, start + s.length(), second, sum);
        }
        return false;
    }
}
}