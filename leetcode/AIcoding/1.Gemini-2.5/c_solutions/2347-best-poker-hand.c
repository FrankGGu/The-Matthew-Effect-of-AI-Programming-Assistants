#include <stdbool.h>

char * bestHand(int* ranks, int ranksSize, char* suits, int suitsSize){
    // Check for Flush
    bool is_flush = true;
    for (int i = 1; i < suitsSize; i++) {
        if (suits[i] != suits[0]) {
            is_flush = false;
            break;
        }
    }
    if (is_flush) {
        return "Flush";
    }

    // Check for Three of a Kind, Pair, or High Card
    int rank_counts[14] = {0}; // Ranks are 1-13

    for (int i = 0; i < ranksSize; i++) {
        rank_counts[ranks[i]]++;
    }

    bool has_three_of_a_kind = false;
    bool has_pair = false;

    for (int i = 1; i <= 13; i++) {
        if (rank_counts[i] >= 3) {
            has_three_of_a_kind = true;
            break;
        }
    }

    if (has_three_of_a_kind) {
        return "Three of a Kind";
    }

    for (int i = 1; i <= 13; i++) {
        if (rank_counts[i] >= 2) {
            has_pair = true;
            break;
        }
    }

    if (has_pair) {
        return "Pair";
    }

    return "High Card";
}