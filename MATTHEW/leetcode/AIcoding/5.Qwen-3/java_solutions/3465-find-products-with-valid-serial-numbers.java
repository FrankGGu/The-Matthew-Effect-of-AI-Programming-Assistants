public class Solution {

import java.util.*;

public class Solution {
    public List<String> findProducts(String[] products, String pattern) {
        List<String> result = new ArrayList<>();
        for (String product : products) {
            if (matchesPattern(product, pattern)) {
                result.add(product);
            }
        }
        return result;
    }

    private boolean matchesPattern(String product, String pattern) {
        int p = 0, s = 0;
        while (p < pattern.length() && s < product.length()) {
            if (pattern.charAt(p) == product.charAt(s)) {
                p++;
                s++;
            } else {
                s++;
            }
        }
        return p == pattern.length();
    }
}
}