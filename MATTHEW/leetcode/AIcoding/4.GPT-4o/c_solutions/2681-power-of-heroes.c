int powerOfHeroes(int* heroes, int heroesSize) {
    int max_power = 0;
    for (int i = 0; i < heroesSize; i++) {
        max_power += heroes[i] * heroes[i];
    }
    return max_power;
}