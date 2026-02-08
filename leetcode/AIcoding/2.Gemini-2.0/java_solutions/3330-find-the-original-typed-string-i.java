class Solution {
    public String findOriginalString(String s) {
        StringBuilder original = new StringBuilder();
        int i = 0;
        while (i < s.length()) {
            int j = i;
            while (j < s.length() && Character.isDigit(s.charAt(j))) {
                j++;
            }
            if (j > i) {
                int count = Integer.parseInt(s.substring(i, j));
                original.append(String.valueOf(original).repeat(count - 1));
                i = j;
            } else {
                original.append(s.charAt(i));
                i++;
            }
        }
        return original.toString();
    }
}