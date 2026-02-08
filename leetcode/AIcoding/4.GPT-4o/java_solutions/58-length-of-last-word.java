class Solution {
    public int lengthOfLastWord(String s) {
        String trimmed = s.trim();
        int lastSpaceIndex = trimmed.lastIndexOf(' ');
        return trimmed.length() - lastSpaceIndex - 1;
    }
}