class Solution {
    public boolean checkZeroOnes(String s) {
        int maxOnes = 0;
        int maxZeros = 0;
        int currentOnes = 0;
        int currentZeros = 0;

        for (char c : s.toCharArray()) {
            if (c == '1') {
                currentOnes++;
                currentZeros = 0;
            } else {
                currentZeros++;
                currentOnes = 0;
            }
            maxOnes = Math.max(maxOnes, currentOnes);
            maxZeros = Math.max(maxZeros, currentZeros);
        }

        return maxOnes > maxZeros;
    }
}