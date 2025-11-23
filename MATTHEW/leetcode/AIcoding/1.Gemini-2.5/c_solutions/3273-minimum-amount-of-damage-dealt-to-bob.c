#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

int minDamageDealtToBob(int* attacks, int attacksSize, int bobHealth) {
    int totalDamageSum = 0;
    for (int i = 0; i < attacksSize; ++i) {
        totalDamageSum += attacks[i];
    }

    // If total possible damage is less than Bob's health, it's impossible to defeat him.
    if (totalDamageSum < bobHealth) {
        return -1;
    }

    // dp[d] will be true if it's possible to deal exactly 'd' damage.
    // The maximum possible damage we might need to consider is totalDamageSum,
    // as any damage beyond that can be achieved by simply adding more attacks
    // that don't contribute to minimizing damage.
    // However, to ensure we can reach bobHealth, we need to consider up to totalDamageSum.
    // If bobHealth is 0, we can deal 0 damage.
    if (bobHealth == 0) {
        return 0;
    }

    int dpSize = totalDamageSum + 1;
    bool* dp = (bool*)calloc(dpSize, sizeof(bool));
    if (dp == NULL) {
        // Handle memory allocation failure
        return -1; // Or throw an error, depending on problem spec
    }

    dp[0] = true; // It's possible to deal 0 damage by choosing no attacks.

    // Iterate through each attack
    for (int i = 0; i < attacksSize; ++i) {
        int currentAttackDamage = attacks[i];
        // Iterate backwards to ensure each attack is used at most once (0/1 knapsack style)
        for (int d = dpSize - 1; d >= currentAttackDamage; --d) {
            if (dp[d - currentAttackDamage]) {
                dp[d] = true;
            }
        }
    }

    // Find the minimum damage 'd' such that d >= bobHealth and dp[d] is true
    int minDamage = -1;
    for (int d = bobHealth; d <= totalDamageSum; ++d) {
        if (dp[d]) {
            minDamage = d;
            break; // Found the smallest possible damage
        }
    }

    free(dp);
    return minDamage;
}