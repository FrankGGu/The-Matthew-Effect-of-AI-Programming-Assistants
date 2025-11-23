class Solution {
    public int transformedStringLength(String s) {
        int n = s.length();
        int totalLength = 0;
        for (char c : s.toCharArray()) {
            if (c == 'a') {
                totalLength += 2;
            } else {
                totalLength += 1;
            }
        }
        return totalLength;
    }
}