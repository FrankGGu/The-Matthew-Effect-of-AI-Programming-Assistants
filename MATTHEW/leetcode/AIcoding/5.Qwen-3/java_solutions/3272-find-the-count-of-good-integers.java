public class Solution {

import java.util.*;

public class Solution {
    public int countGoodIntegers(int n) {
        int count = 0;
        for (int i = 1; i <= n; i++) {
            String s = String.valueOf(i);
            int sum = 0;
            for (char c : s.toCharArray()) {
                sum += c - '0';
            }
            if (sum % 3 == 0) {
                count++;
            }
        }
        return count;
    }
}
}