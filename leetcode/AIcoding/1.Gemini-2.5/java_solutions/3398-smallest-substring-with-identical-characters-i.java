class Solution {
    public int smallestSubstringWithIdenticalCharacters(String s) {
        if (s.length() <= 1) {
            return 1;
        }

        for (int i = 0; i < s.length() - 1; i++) {
            if (s.charAt(i) == s.charAt(i + 1)) {
                return 2;
            }
        }

        return 1;
    }
}