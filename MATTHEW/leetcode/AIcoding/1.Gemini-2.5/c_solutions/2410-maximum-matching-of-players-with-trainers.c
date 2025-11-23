#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxMatchingPlayersWithTrainers(int* players, int playersSize, int* trainers, int trainersSize) {
    qsort(players, playersSize, sizeof(int), compare);
    qsort(trainers, trainersSize, sizeof(int), compare);

    int matches = 0;
    int player_idx = 0;
    int trainer_idx = 0;

    while (player_idx < playersSize && trainer_idx < trainersSize) {
        if (players[player_idx] <= trainers[trainer_idx]) {
            matches++;
            player_idx++;
            trainer_idx++;
        } else {
            trainer_idx++;
        }
    }

    return matches;
}