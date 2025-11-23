class Solution {
    public String licenseKeyFormatting(String s, int k) {
        StringBuilder sb = new StringBuilder();
        for (int i = s.length() - 1; i >= 0; i--) {
            char c = s.charAt(i);
            if (c != '-') {
                sb.append(Character.toUpperCase(c));
            }
        }

        StringBuilder result = new StringBuilder();
        int count = 0;
        for (int i = sb.length() - 1; i >= 0; i--) {
            result.append(sb.charAt(i));
            count++;
            if (count == k && i != 0) {
                result.append('-');
                count = 0;
            }
        }
        return result.reverse().toString();
    }
}