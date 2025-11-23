#include <stdlib.h> // For qsort
#include <limits.h> // For INT_MAX

int comparePlayers(const void* a, const void* b) {
    const int* playerA = *(const int**)a;
    const int* playerB = *(const int**)b;

    if (playerA[0] != playerB[0]) {
        return playerA[0] - playerB[0]; // Sort by attack ascending
    }
    return playerA[1] - playerB[1]; // If attack is same, sort by defense ascending
}

int findNumberOfWinningPlayers(int** players, int playersSize, int* playersColSize) {
    if (playersSize <= 1) {
        return 0; // A player must win against *at least one other player*.
                  // If there's 0 or 1 player, no one can win against *another* player.
    }

    // Sort the players based on the custom comparison function
    qsort(players, playersSize, sizeof(int*), comparePlayers);

    int winningPlayersCount = 0;

    // minDefensePreviousAttack tracks the minimum defense value encountered
    // among players whose attack is *strictly less* than the current player's attack.
    int minDefensePreviousAttack = INT_MAX;

    // currentAttackGroupMinDefense tracks the minimum defense value for players
    // within the *current* attack group (i.e., players with the same attack value).
    int currentAttackGroupMinDefense = INT_MAX;

    for (int i = 0; i < playersSize; ++i) {
        int currentAttack = players[i][0];
        int currentDefense = players[i][1];

        // If we are moving to a new attack group (or it's the first player)
        // and the previous player had a strictly smaller attack,
        // then update minDefensePreviousAttack with the minimum defense from the
        // *entire* previous attack group.
        if (i > 0 && players[i-1][0] < currentAttack) {
            if (currentAttackGroupMinDefense < minDefensePreviousAttack) {
                minDefensePreviousAttack = currentAttackGroupMinDefense;
            }
            // Reset currentAttackGroupMinDefense for the new group
            currentAttackGroupMinDefense = INT_MAX;
        }

        // A player `i` wins against some player `j` if:
        // players[i][0] > players[j][0] AND players[i][1] > players[j][1].
        //
        // After sorting, if `currentDefense > minDefensePreviousAttack`, it means
        // there exists at least one player `j` that contributed to `minDefensePreviousAttack`
        // such that `players[j][0] < currentAttack` and `players[j][1] < currentDefense`.
        // This satisfies the winning condition.
        if (currentDefense > minDefensePreviousAttack) {
            winningPlayersCount++;
        }

        // Update currentAttackGroupMinDefense with the minimum defense in the current group.
        // This is necessary for when the attack value changes in the next iteration.
        if (currentDefense < currentAttackGroupMinDefense) {
            currentAttackGroupMinDefense = currentDefense;
        }
    }

    return winningPlayersCount;
}