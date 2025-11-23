int maxAltitude(int* gain, int gainSize) {
    int maxAlt = 0, currentAlt = 0;
    for (int i = 0; i < gainSize; i++) {
        currentAlt += gain[i];
        if (currentAlt > maxAlt) {
            maxAlt = currentAlt;
        }
    }
    return maxAlt;
}