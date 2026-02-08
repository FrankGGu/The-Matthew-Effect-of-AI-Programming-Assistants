int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

long long minimumDamage(int power, int* damage, int damageSize, int* health, int healthSize) {
    int n = damageSize;
    int** monsters = malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        monsters[i] = malloc(2 * sizeof(int));
        monsters[i][0] = damage[i];
        monsters[i][1] = health[i];
    }

    qsort(monsters, n, sizeof(int*), cmp);

    long long total_damage = 0;
    long long attacks = 0;

    for (int i = 0; i < n; i++) {
        int dmg = monsters[i][0];
        int hp = monsters[i][1];

        long long needed = (hp + power - 1) / power;
        total_damage += (attacks + needed) * dmg;
        attacks += needed;

        free(monsters[i]);
    }
    free(monsters);

    return total_damage;
}