bool checkZeroOnes(char * s){
    int maxOnes = 0, maxZeros = 0, currentOnes = 0, currentZeros = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '1') {
            currentOnes++;
            if (currentZeros > 0) {
                maxZeros = (currentZeros > maxZeros) ? currentZeros : maxZeros;
                currentZeros = 0;
            }
        } else {
            currentZeros++;
            if (currentOnes > 0) {
                maxOnes = (currentOnes > maxOnes) ? currentOnes : maxOnes;
                currentOnes = 0;
            }
        }
    }
    maxOnes = (currentOnes > maxOnes) ? currentOnes : maxOnes;
    maxZeros = (currentZeros > maxZeros) ? currentZeros : maxZeros;

    return maxOnes > maxZeros;
}