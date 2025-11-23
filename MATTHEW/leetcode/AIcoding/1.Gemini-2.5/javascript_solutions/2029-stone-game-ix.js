var stoneGameIX = function(stones) {
    let count1 = 0; // stones with value % 3 == 1
    let count2 = 0; // stones with value % 3 == 2
    let count0 = 0; // stones with value % 3 == 0

    for (const stone of stones) {
        if (stone % 3 === 1) {
            count1++;
        } else if (stone % 3 === 2) {
            count2++;
        } else {
            count0++;
        }
    }

    // Alice must pick a stone with value not divisible by 3 on her first turn.
    // If she picks a stone with value divisible by 3, the sum becomes divisible by 3, and she loses.
    // So, if there are no stones with value not divisible by 3, Alice loses.
    if (count1 === 0 && count2 === 0) {
        return false;
    }

    // The number of stones divisible by 3 (count0) affects the game.
    // These stones can be used to "pass" a turn without changing the sum modulo 3,
    // as long as the current sum is not divisible by 3.
    // The parity of count0 is crucial.

    if (count0 % 2 === 0) { // Even number of 0-stones
        // If count0 is even, these stones effectively cancel each other out in terms of turn-swapping.
        // Alice wins if she can force Bob to make the sum divisible by 3.
        // 1. If Alice has both type 1 and type 2 stones, she can always win.
        //    She can pick a stone to leave Bob in a state where he is forced to lose.
        // 2. If Alice only has type 1 stones (count2 === 0), she wins if count1 % 3 == 2.
        //    (e.g., if count1=2, A picks 1 (S=1), B picks 1 (S=2), A has no moves, S=2, A wins by problem rule).
        // 3. If Alice only has type 2 stones (count1 === 0), she wins if count2 % 3 == 2. (Symmetric to case 2).
        return (count1 > 0 && count2 > 0) || (count1 === 0 && count2 % 3 === 2) || (count2 === 0 && count1 % 3 === 2);
    } else { // Odd number of 0-stones
        // If count0 is odd, the last 0-stone effectively swaps whose turn it is for the critical 1 or 2 stone moves.
        // Alice picks a stone (1 or 2). Then it's Bob's turn, and the remaining count0 is even.
        // Alice wins if she can make a move such that Bob faces a losing state (for Bob, with even remaining count0).
        // 1. If Alice has both type 1 and type 2 stones, she wins if their counts are not equal (count1 != count2).
        //    If count1 == count2, Bob can mirror Alice's moves with 1-stones and 2-stones, and potentially use 0-stones
        //    to pass the turn such that Alice is forced to lose.
        // 2. If Alice only has type 1 stones (count2 === 0), she wins if count1 % 3 == 1.
        //    (e.g., if count1=1, A picks 1 (S=1), Bob has 0-stones, Bob picks 0 (S=1), Alice has no moves, S=1, Alice wins by problem rule).
        // 3. If Alice only has type 2 stones (count1 === 0), she wins if count2 % 3 == 1. (Symmetric to case 2).
        return (count1 > 0 && count2 > 0 && Math.abs(count1 - count2) !== 0) || (count1 === 0 && count2 % 3 === 1) || (count2 === 0 && count1 % 3 === 1);
    }
};