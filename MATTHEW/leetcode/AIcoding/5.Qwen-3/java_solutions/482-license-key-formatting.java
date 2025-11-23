public class Solution {
    public String licenseKeyFormatting(String s) {
        StringBuilder result = new StringBuilder();
        int count = 0;
        for (int i = s.length() - 1; i >= 0; i--) {
            char c = s.charAt(i);
            if (c != '-') {
                if (count > 0 && count % 4 == 0) {
                    result.append('-');
                }
                result.append(Character.toUpperCase(c));
                count++;
            }
        }
        return result.reverse().toString();
    }
}