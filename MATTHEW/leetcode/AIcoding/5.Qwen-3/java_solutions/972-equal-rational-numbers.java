public class Solution {

import java.util.*;

public class Solution {
    public boolean isRationalEqual(String s, String t) {
        return parse(s).equals(parse(t));
    }

    private BigDecimal parse(String s) {
        if (s.contains("(")) {
            int idx = s.indexOf('(');
            String integerPart = s.substring(0, idx);
            String repeatingPart = s.substring(idx + 1, s.length() - 1);
            return new BigDecimal(integerPart).add(new BigDecimal(repeatingPart).divide(new BigDecimal("9".repeat(repeatingPart.length()))));
        } else {
            return new BigDecimal(s);
        }
    }
}
}