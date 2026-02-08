#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *name;
    int damage;
} Fighter;

int compare(const void *a, const void *b) {
    Fighter *f1 = (Fighter *)a;
    Fighter *f2 = (Fighter *)b;
    return f2->damage - f1->damage;
}

long long minDamage(char **attackers, int attackersSize, int *damage, int damageSize) {
    Fighter *fighters = (Fighter *)malloc(attackersSize * sizeof(Fighter));
    for (int i = 0; i < attackersSize; i++) {
        fighters[i].name = attackers[i];
        fighters[i].damage = damage[i];
    }
    qsort(fighters, attackersSize, sizeof(Fighter), compare);

    long long totalDamage = 0;
    for (int i = 0; i < attackersSize; i++) {
        totalDamage += (long long)(i + 1) * fighters[i].damage;
    }

    free(fighters);
    return totalDamage;
}