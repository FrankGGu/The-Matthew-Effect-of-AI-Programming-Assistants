#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDamage(int* armor, int armorSize, int* damage, int damageSize) {
    int max_damage = 0;
    int max_index = -1;
    long long total_damage = 0;

    for (int i = 0; i < damageSize; i++) {
        total_damage += damage[i];
        if (damage[i] > max_damage) {
            max_damage = damage[i];
            max_index = i;
        }
    }

    if (max_index != -1) {
        total_damage -= max_damage;
        total_damage += (max_damage > armor[max_index] ? armor[max_index] : max_damage);
    }

    return (int)total_damage;
}