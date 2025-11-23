class Solution {
    public String findOriginalString(String typed) {
        StringBuilder original = new StringBuilder();
        int i = 0;
        while (i < typed.length()) {
            char current = typed.charAt(i);
            original.append(current);
            int j = i + 1;
            while (j < typed.length() && typed.charAt(j) == current) {
                j++;
            }
            i = j;
        }
        return original.toString();
    }
}