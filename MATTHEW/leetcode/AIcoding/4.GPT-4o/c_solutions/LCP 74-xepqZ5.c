int strongestForce(int* strength, int strengthSize) {
    int maxStrength = 0;
    for (int i = 0; i < strengthSize; i++) {
        maxStrength = fmax(maxStrength, strength[i]);
    }
    return maxStrength;
}