var xorGame = function(nums) {
    let xorSum = 0;
    for (let i = 0; i < nums.length; i++) {
        xorSum ^= nums[i];
    }

    // Alice wins if the initial XOR sum of all numbers is 0.
    // This is because if the XOR sum is already 0 at the start of her turn,
    // she hasn't made a move yet, so the losing condition "if a player's move
    // results in the XOR sum... becoming 0, that player loses immediately" does not apply to her.
    // If she makes a move, she would pick a number `x`. The remaining numbers would XOR to `x`.
    // She then writes `x` on the board. The new XOR sum of the board would be `x ^ x = 0`.
    // This would cause her to lose.
    // However, the standard interpretation for this problem is that if the XOR sum is 0 at the start of your turn, you win.
    // This is a common nuance in competitive programming problems.

    if (xorSum === 0) {
        return true;
    }

    // If the initial XOR sum is not 0, Alice wins if and only if the number of elements is even.
    // If the number of elements is odd, Alice loses.
    // This is because if the number of elements is even, Alice can always make a move such that
    // the next player (Bob) faces a state where the number of elements is odd and the XOR sum is non-zero.
    // From such a state, the next player (Bob) will be forced to lose.
    // If the number of elements is odd, Alice will always be forced to pass a state to Bob
    // where the number of elements is even. Bob can then apply a similar strategy.
    // The game effectively comes down to who faces an odd number of elements when the XOR sum is non-zero.
    // Alice wins if she can always ensure Bob faces this losing state.
    // This happens if the initial number of elements is even.
    return nums.length % 2 === 0;
};