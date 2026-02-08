class Solution {
    public boolean checkZeroOnes(String s) {
        int maxOne = 0, maxZero = 0;
        int currentOne = 0, currentZero = 0;

        for (char c : s.toCharArray()) {
            if (c == '1') {
                currentOne++;
                currentZero = 0;
                maxOne = Math.max(maxOne, currentOne);
            } else {
                currentZero++;
                currentOne = 0;
                maxZero = Math.max(maxZero, currentZero);
            }
        }

        return maxOne > maxZero;
    }
}