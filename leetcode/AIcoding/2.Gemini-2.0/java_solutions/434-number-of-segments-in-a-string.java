class Solution {
    public int countSegments(String s) {
        if (s == null || s.trim().isEmpty()) {
            return 0;
        }
        String trimmedString = s.trim();
        return trimmedString.split("\\s+").length;
    }
}