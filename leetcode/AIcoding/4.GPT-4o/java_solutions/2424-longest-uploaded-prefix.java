class Solution {
    public int longestUploadedPrefix(String[] uploaded) {
        int maxLength = 0;
        for (String file : uploaded) {
            if (file.length() > maxLength) {
                maxLength = file.length();
            }
        }
        return maxLength;
    }
}