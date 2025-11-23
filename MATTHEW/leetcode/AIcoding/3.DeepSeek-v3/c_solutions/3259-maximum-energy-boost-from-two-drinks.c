int maxEnergyBoost(int* energyDrinkA, int energyDrinkASize, int* energyDrinkB, int energyDrinkBSize) {
    int n = energyDrinkASize;
    long long dpA = energyDrinkA[0];
    long long dpB = energyDrinkB[0];

    for (int i = 1; i < n; i++) {
        long long newA = (dpA + energyDrinkA[i] > dpB) ? dpA + energyDrinkA[i] : dpB;
        long long newB = (dpB + energyDrinkB[i] > dpA) ? dpB + energyDrinkB[i] : dpA;
        dpA = newA;
        dpB = newB;
    }

    return (dpA > dpB) ? dpA : dpB;
}