class Solution {
    public boolean areColorsTheSame(String square1, String square2) {
        int parity1 = ((square1.charAt(0) - 'a') + (square1.charAt(1) - '1')) % 2;
        int parity2 = ((square2.charAt(0) - 'a') + (square2.charAt(1) - '1')) % 2;

        return parity1 == parity2;
    }
}