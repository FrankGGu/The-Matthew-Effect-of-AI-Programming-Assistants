class Solution {
    public String smallestString(String s) {
        StringBuilder sb = new StringBuilder(s);
        int i = 0;
        while (i < sb.length() - 1) {
            if (sb.charAt(i) > sb.charAt(i + 1)) {
                sb.deleteCharAt(i);
                if (i > 0) {
                    i--;
                }
            } else {
                i++;
            }
        }
        return sb.toString();
    }
}