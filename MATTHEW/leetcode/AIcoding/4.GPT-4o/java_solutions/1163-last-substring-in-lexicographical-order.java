class Solution {
    public String lastSubstring(String s) {
        int n = s.length();
        int maxIndex = 0;
        for (int i = 1; i < n; i++) {
            if (s.charAt(i) > s.charAt(maxIndex)) {
                maxIndex = i;
            } else if (s.charAt(i) == s.charAt(maxIndex)) {
                int j = maxIndex;
                while (j < n && s.charAt(j) == s.charAt(i)) {
                    j++;
                    i++;
                }
                if (j == n || s.charAt(j) > s.charAt(maxIndex)) {
                    maxIndex = i - 1;
                }
            }
        }
        return s.substring(maxIndex);
    }
}