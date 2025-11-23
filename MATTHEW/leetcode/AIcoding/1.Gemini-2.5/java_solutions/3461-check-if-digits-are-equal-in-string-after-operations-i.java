class Solution {
    public boolean areDigitsEqual(String s) {
        int firstCalculatedDigit = -1;

        for (int i = 0; i < s.length(); i += 2) {
            char letter = s.charAt(i);
            int currentCalculatedDigit = letter - 'a';

            if (i == 0) {
                firstCalculatedDigit = currentCalculatedDigit;
            } else {
                if (currentCalculatedDigit != firstCalculatedDigit) {
                    return false;
                }
            }
        }

        return true;
    }
}