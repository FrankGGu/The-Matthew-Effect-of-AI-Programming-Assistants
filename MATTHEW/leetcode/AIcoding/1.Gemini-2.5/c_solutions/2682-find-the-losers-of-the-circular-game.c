#include <stdlib.h>
#include <stdbool.h>

int* findLosers(int n, int k, int* returnSize) {
    // Use a boolean array to track which players have received the ball.
    // Players are 0-indexed internally (0 to n-1).
    // Initialize all to false (no one has received the ball yet).
    bool* received = (bool*) calloc(n, sizeof(bool));
    // Handle potential malloc failure
    if (received == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int current_player_0_indexed = 0; // Player 0 (which is player 1 in problem statement) starts with the ball.
    int round = 1;

    // Mark the starting player as having received the ball.
    received[current_player_0_indexed] = true;

    // Simulate the game rounds.
    while (true) {
        // Calculate the number of steps for the current round.
        long long steps = (long long)round * k; // Use long long for steps to prevent overflow before modulo, though int should be sufficient for n, k <= 1000.

        // Calculate the next player's 0-indexed position.
        current_player_0_indexed = (current_player_0_indexed + steps) % n;

        // Check if this player has already received the ball.
        if (received[current_player_0_indexed]) {
            // If yes, the game ends.
            break;
        } else {
            // If no, mark this player as having received the ball.
            received[current_player_0_indexed] = true;
            round++; // Increment the round for the next pass.
        }
    }

    // After the game ends, count the number of players who never received the ball.
    int losers_count = 0;
    for (int i = 0; i < n; i++) {
        if (!received[i]) {
            losers_count++;
        }
    }

    // Allocate memory for the result array to store the 1-indexed losers.
    int* losers = (int*) malloc(losers_count * sizeof(int));
    // Handle potential malloc failure
    if (losers == NULL) {
        *returnSize = 0;
        free(received); // Free the temporary array before returning
        return NULL;
    }

    // Populate the result array with the 1-indexed losers.
    int index = 0;
    for (int i = 0; i < n; i++) {
        if (!received[i]) {
            losers[index++] = i + 1; // Convert 0-indexed player to 1-indexed.
        }
    }

    // Set the returnSize for the caller.
    *returnSize = losers_count;

    // Free the temporary array used for tracking received players.
    free(received);

    return losers;
}