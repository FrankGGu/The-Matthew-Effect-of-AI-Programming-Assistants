int maxEnergy(int* energy, int energySize, int k) {
    int maxEnergy = INT_MIN;
    for (int start = 0; start < k; start++) {
        int currentEnergy = 0;
        for (int i = start; i < energySize; i += k) {
            currentEnergy += energy[i];
        }
        if (currentEnergy > maxEnergy) {
            maxEnergy = currentEnergy;
        }
    }
    return maxEnergy;
}