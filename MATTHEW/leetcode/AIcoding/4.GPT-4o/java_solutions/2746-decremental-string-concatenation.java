class Solution {
    public String decrementalString(String s) {
        StringBuilder result = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (c >= 'a' && c <= 'z') {
                result.append(c);
            }
        }
        return result.toString();
    }
}