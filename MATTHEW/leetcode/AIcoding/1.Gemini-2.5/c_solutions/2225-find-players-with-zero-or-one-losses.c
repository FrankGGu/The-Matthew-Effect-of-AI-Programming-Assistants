#include <stdlib.h>
#include <string.h> // For memset and memcpy

#define MAX_PLAYER_ID 100001 // Player IDs are 1-indexed up to 10^5, so array size needs to be 100001 for indices 0 to 100000.

int** findWinners(int** matches, int matchesSize, int* matchesColSize, int* returnSize, int** returnColumnSizes) {
    // losses[i] stores the number of losses for player i. Initialized to 0.
    int losses[MAX_PLAYER_ID];
    // seen_players[i] indicates if player i has participated in any match.
    // 0: not seen, 1: seen. Initialized to 0.
    int seen_players[MAX_PLAYER_ID]; 

    // Initialize arrays to 0
    memset(losses, 0, sizeof(losses));
    memset(seen_players, 0, sizeof(seen_players));

    // Process each match to update loss counts and mark players as seen
    for (int i = 0; i < matchesSize; i++) {
        int winner = matches[i][0];
        int loser = matches[i][1];

        seen_players[winner] = 1;
        seen_players[loser] = 1;
        losses[loser]++; // Increment loss count for the loser
    }

    // Prepare temporary dynamic arrays for players with 0 and 1 losses
    int* zeroLossPlayers = NULL;
    int zeroLossCount = 0;
    int zeroLossCapacity = MAX_PLAYER_ID / 2; // Initial capacity for dynamic array

    int* oneLossPlayers = NULL;
    int oneLossCount = 0;
    int oneLossCapacity = MAX_PLAYER_ID / 2; // Initial capacity for dynamic array

    // Allocate initial memory for dynamic arrays
    zeroLossPlayers = (int*)malloc(zeroLossCapacity * sizeof(int));
    oneLossPlayers = (int*)malloc(oneLossCapacity * sizeof(int));

    // Iterate through all possible player IDs (from 1 up to MAX_PLAYER_ID - 1)
    // This ensures players are added to the lists in ascending order of their IDs, fulfilling the sorting requirement.
    for (int i = 1; i < MAX_PLAYER_ID; i++) {
        if (seen_players[i] == 1) { // Check if player i has participated in any match
            if (losses[i] == 0) { // Player has 0 losses
                if (zeroLossCount == zeroLossCapacity) {
                    zeroLossCapacity *= 2; // Double capacity if needed
                    zeroLossPlayers = (int*)realloc(zeroLossPlayers, zeroLossCapacity * sizeof(int));
                }
                zeroLossPlayers[zeroLossCount++] = i;
            } else if (losses[i] == 1) { // Player has exactly 1 loss
                if (oneLossCount == oneLossCapacity) {
                    oneLossCapacity *= 2; // Double capacity if needed
                    oneLossPlayers = (int*)realloc(oneLossPlayers, oneLossCapacity * sizeof(int));
                }
                oneLossPlayers[oneLossCount++] = i;
            }
        }
    }

    // Set the return size and column sizes for the result
    *returnSize = 2; // We always return two lists: 0-loss players and 1-loss players
    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    (*returnColumnSizes)[0] = zeroLossCount;
    (*returnColumnSizes)[1] = oneLossCount;

    // Allocate memory for the final result array (an array of 2 int pointers)
    int** result = (int**)malloc(2 * sizeof(int*));

    // Allocate memory for the actual player lists and copy data from temporary arrays
    result[0] = (int*)malloc(zeroLossCount * sizeof(int));
    memcpy(result[0], zeroLossPlayers, zeroLossCount * sizeof(int));

    result[1] = (int*)malloc(oneLossCount * sizeof(int));
    memcpy(result[1], oneLossPlayers, oneLossCount * sizeof(int));

    // Free the temporary dynamic arrays
    free(zeroLossPlayers);
    free(oneLossPlayers);

    return result;
}