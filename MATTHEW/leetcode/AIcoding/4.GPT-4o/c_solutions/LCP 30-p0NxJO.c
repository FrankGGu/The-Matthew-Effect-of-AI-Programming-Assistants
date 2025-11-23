int magicTower(int* monsters, int monstersSize) {
    long long sum = 0;
    long long health = 1;

    for (int i = 0; i < monstersSize; ++i) {
        sum += monsters[i];
        if (sum < 0) {
            health -= sum; 
            sum = 0;
        }
    }

    return health <= 0 ? -1 : health;
}