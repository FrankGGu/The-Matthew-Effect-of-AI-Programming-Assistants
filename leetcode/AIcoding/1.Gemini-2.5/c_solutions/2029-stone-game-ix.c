#include <stdbool.h>

bool stoneGameIX(int* stones, int stonesSize) {
    int count0 = 0;
    int count1 = 0;
    int count2 = 0;

    for (int i = 0; i < stonesSize; i++) {
        int remainder = stones[i] % 3;
        if (remainder == 0) {
            count0++;
        } else if (remainder == 1) {
            count1++;
        } else { // remainder == 2
            count2++;
        }
    }

    // Alice's first move:
    // The initial sum is 0. Alice cannot pick a stone with value % 3 == 0.
    // She must pick a stone with value % 3 == 1 or value % 3 == 2.
    // If there are no such stones, she cannot make a valid first move and loses.
    if (count1 == 0 && count2 == 0) {
        return false;
    }

    // W1: Represents if Alice can win by starting with a stone of value % 3 == 1.
    // If Alice picks a stone of type 1:
    // The sum becomes 1. Bob's turn. Bob must pick a stone of type 1 (to make sum 2)
    // or type 0 (to make sum 1). Bob cannot pick type 2 (sum would be 0).
    // Alice's turn. If sum is 2, Alice must pick type 2 (to make sum 1) or type 0 (to make sum 2).
    // Alice wins this subgame if she can make her moves and Bob cannot make his.
    // This happens if the number of type 1 stones available for Bob (count1 - 1 after Alice's first move)
    // is less than or equal to the number of type 2 stones available for Alice (count2).
    // This path is only possible if Alice has at least one type 1 stone to pick initially.
    bool W1 = (count1 > 0 && count1 - 1 <= count2);

    // W2: Represents if Alice can win by starting with a stone of value % 3 == 2.
    // If Alice picks a stone of type 2:
    // The sum becomes 2. Bob's turn. Bob must pick a stone of type 2 (to make sum 1)
    // or type 0 (to make sum 2). Bob cannot pick type 1 (sum would be 0).
    // Alice's turn. If sum is 1, Alice must pick type 1 (to make sum 2) or type 0 (to make sum 1).
    // Alice wins this subgame if she can make her moves and Bob cannot make his.
    // This happens if the number of type 2 stones available for Bob (count2 - 1 after Alice's first move)
    // is less than or equal to the number of type 1 stones available for Alice (count1).
    // This path is only possible if Alice has at least one type 2 stone to pick initially.
    bool W2 = (count2 > 0 && count2 - 1 <= count1);

    // Alice wins in the game without considering stones of value % 3 == 0 if she has a winning move.
    bool alice_wins_without_c0 = W1 || W2;

    // Stones with value % 3 == 0 (count0) do not change the sum modulo 3.
    // A player can use a type 0 stone if the current sum is not a multiple of 3.
    // This effectively allows a player to "pass" their turn without changing the sum state.
    // If count0 is even, both players can use an equal number of type 0 stones,
    // so the outcome of the game (who makes the last move) remains the same as if count0 was 0.
    // If count0 is odd, one player gets an "extra" pass. This effectively flips the outcome
    // of the game played with only type 1 and type 2 stones.
    // So, Alice wins if (count0 is even AND Alice wins without c0) OR (count0 is odd AND Alice loses without c0).
    // This can be compactly written as: (count0 % 2 == 0) == alice_wins_without_c0.
    return (count0 % 2 == 0) == alice_wins_without_c0;
}