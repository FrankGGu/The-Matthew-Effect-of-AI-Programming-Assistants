public class Solution {
    public boolean checkZeroOnes(String s) {
        int maxOnes = 0, maxZeros = 0, currentOnes = 0, currentZeros = 0;

        for (char c : s.toCharArray()) {
            if (c == '1') {
                currentOnes++;
                maxZeros = Math.max(maxZeros, currentZeros);
                currentZeros = 0;
            } else {
                currentZeros++;
                maxOnes = Math.max(maxOnes, currentOnes);
                currentOnes = 0;
            }
        }

        maxOnes = Math.max(maxOnes, currentOnes);
        maxZeros = Math.max(maxZeros, currentZeros);

        return maxOnes > maxZeros;
    }
}