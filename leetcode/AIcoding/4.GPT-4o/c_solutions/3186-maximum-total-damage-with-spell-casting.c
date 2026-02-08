int maximumDamage(int* damage, int damageSize, int* spell, int spellSize, int k) {
    int maxDamage = 0;
    for (int i = 0; i < damageSize; i++) {
        int currentDamage = damage[i];
        for (int j = 0; j < spellSize; j++) {
            if (j < k) {
                currentDamage += spell[j];
            }
        }
        if (currentDamage > maxDamage) {
            maxDamage = currentDamage;
        }
    }
    return maxDamage;
}