class Solution {
    public String smallestSubstring(String s) {
        int n = s.length();
        int minLength = Integer.MAX_VALUE;
        String result = "";

        for (int i = 0; i < n; i++) {
            int j = i;
            while (j < n && s.charAt(j) == s.charAt(i)) {
                j++;
            }
            if (j - i < minLength) {
                minLength = j - i;
                result = s.substring(i, j);
            }
            i = j - 1;
        }

        return result;
    }
}