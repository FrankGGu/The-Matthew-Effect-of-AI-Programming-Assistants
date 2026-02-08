class Solution {
    public boolean canBeEqual(String s, String target) {
        boolean sHasOne = false;
        for (char c : s.toCharArray()) {
            if (c == '1') {
                sHasOne = true;
                break;
            }
        }

        boolean targetHasOne = false;
        for (char c : target.toCharArray()) {
            if (c == '1') {
                targetHasOne = true;
                break;
            }
        }

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '0' && target.charAt(i) == '1') {
                return false;
            }
        }

        return sHasOne == targetHasOne;
    }
}