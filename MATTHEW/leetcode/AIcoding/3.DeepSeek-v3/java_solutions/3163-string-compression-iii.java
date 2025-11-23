class Solution {
    public String compressedString(String word) {
        StringBuilder sb = new StringBuilder();
        int n = word.length();
        int i = 0;
        while (i < n) {
            char current = word.charAt(i);
            int count = 0;
            while (i < n && word.charAt(i) == current && count < 9) {
                i++;
                count++;
            }
            sb.append(count).append(current);
        }
        return sb.toString();
    }
}