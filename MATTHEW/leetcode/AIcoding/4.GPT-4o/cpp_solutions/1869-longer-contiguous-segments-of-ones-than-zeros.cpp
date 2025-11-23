class Solution {
public:
    bool checkZeroOnes(string s) {
        int maxOnes = 0, maxZeros = 0, currentOnes = 0, currentZeros = 0;

        for (char c : s) {
            if (c == '1') {
                currentOnes++;
                maxZeros = max(maxZeros, currentZeros);
                currentZeros = 0;
            } else {
                currentZeros++;
                maxOnes = max(maxOnes, currentOnes);
                currentOnes = 0;
            }
        }

        maxOnes = max(maxOnes, currentOnes);
        maxZeros = max(maxZeros, currentZeros);

        return maxOnes > maxZeros;
    }
};