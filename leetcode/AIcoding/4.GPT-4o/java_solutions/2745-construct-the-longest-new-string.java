class Solution {
    public String longestNewString(String s) {
        StringBuilder result = new StringBuilder();
        Set<Character> seen = new HashSet<>();

        for (char c : s.toCharArray()) {
            if (!seen.contains(c)) {
                seen.add(c);
                result.append(c);
            }
        }

        return result.toString();
    }
}