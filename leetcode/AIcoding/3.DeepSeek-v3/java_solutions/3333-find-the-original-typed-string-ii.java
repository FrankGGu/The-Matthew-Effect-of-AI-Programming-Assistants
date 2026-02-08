class Solution {
    public String findOriginalString(String typed) {
        StringBuilder original = new StringBuilder();
        int i = 0;
        int n = typed.length();
        while (i < n) {
            char current = typed.charAt(i);
            original.append(current);
            int j = i + 1;
            while (j < n && typed.charAt(j) == current) {
                j++;
            }
            int count = j - i;
            if (count % 2 != 0) {
                return "";
            }
            i = j;
        }
        return original.toString();
    }
}