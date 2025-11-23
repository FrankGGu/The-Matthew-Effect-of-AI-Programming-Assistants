class Solution {
    public String encode(String s) {
        StringBuilder result = new StringBuilder();
        int n = s.length();

        for (int i = 0; i < n; i++) {
            int count = 1;
            while (i + 1 < n && s.charAt(i) == s.charAt(i + 1)) {
                count++;
                i++;
            }
            result.append(count).append(s.charAt(i));
        }

        return result.toString();
    }

    public String decode(String s) {
        StringBuilder result = new StringBuilder();
        int n = s.length();

        for (int i = 0; i < n; i++) {
            int count = 0;
            while (i < n && Character.isDigit(s.charAt(i))) {
                count = count * 10 + (s.charAt(i) - '0');
                i++;
            }
            if (i < n) {
                char c = s.charAt(i);
                for (int j = 0; j < count; j++) {
                    result.append(c);
                }
            }
        }

        return result.toString();
    }
}