class Solution {
    public boolean checkZeroOnes(String s) {
        int ones = 0;
        int zeros = 0;
        int currentOnes = 0;
        int currentZeros = 0;

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                currentOnes++;
                currentZeros = 0;
            } else {
                currentZeros++;
                currentOnes = 0;
            }
            ones = Math.max(ones, currentOnes);
            zeros = Math.max(zeros, currentZeros);
        }

        return ones > zeros;
    }
}