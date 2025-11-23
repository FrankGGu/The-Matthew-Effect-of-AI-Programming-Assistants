import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxProduct(String s) {
        int n = s.length();
        Map<Integer, Integer> palindromeMaskToLength = new HashMap<>();

        for (int i = 1; i < (1 << n); i++) {
            StringBuilder sb = new StringBuilder();
            for (int j = 0; j < n; j++) {
                if (((i >> j) & 1) == 1) {
                    sb.append(s.charAt(j));
                }
            }

            String sub = sb.toString();
            if (isPalindrome(sub)) {
                palindromeMaskToLength.put(i, sub.length());
            }
        }

        int maxProd = 0;

        for (Map.Entry<Integer, Integer> entry1 : palindromeMaskToLength.entrySet()) {
            int mask1 = entry1.getKey();
            int len1 = entry1.getValue();

            for (Map.Entry<Integer, Integer> entry2 : palindromeMaskToLength.entrySet()) {
                int mask2 = entry2.getKey();
                int len2 = entry2.getValue();

                if ((mask1 & mask2) == 0) {
                    maxProd = Math.max(maxProd, len1 * len2);
                }
            }
        }

        return maxProd;
    }

    private boolean isPalindrome(String str) {
        int left = 0;
        int right = str.length() - 1;
        while (left < right) {
            if (str.charAt(left) != str.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}