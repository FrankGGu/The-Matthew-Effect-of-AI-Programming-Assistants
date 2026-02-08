class Solution {
    public int lengthOfLastWord(String s) {
        String trimmedS = s.trim();
        int lastSpaceIndex = trimmedS.lastIndexOf(' ');
        if (lastSpaceIndex == -1) {
            return trimmedS.length();
        } else {
            return trimmedS.length() - (lastSpaceIndex + 1);
        }
    }
}