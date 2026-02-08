public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> divisibilityArray(String word) {
        List<Integer> result = new ArrayList<>();
        long current = 0;
        int mod = 10;
        for (char c : word.toCharArray()) {
            current = (current * 10 + (c - '0')) % mod;
            if (current == 0) {
                result.add(1);
            } else {
                result.add(0);
            }
        }
        return result;
    }
}
}