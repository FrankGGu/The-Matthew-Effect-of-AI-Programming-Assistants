public class Solution {

import java.util.*;

public class Solution {
    public int minAdditions(String s) {
        int res = 0;
        int open = 0;
        for (char c : s.toCharArray()) {
            if (c == '(') {
                open++;
            } else {
                if (open > 0) {
                    open--;
                } else {
                    res++;
                }
            }
        }
        return res + open;
    }
}
}