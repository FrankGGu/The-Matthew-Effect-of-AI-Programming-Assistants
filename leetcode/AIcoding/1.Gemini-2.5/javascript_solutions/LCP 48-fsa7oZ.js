var canWin = function(tx, ty) {
    // The problem "无限棋局" (Infinite Chessboard) typically refers to an impartial game
    // played on an infinite 2D grid.
    // Starting at (0,0), two players take turns moving a piece.
    // In each turn, a player can move the piece one step in any of the four cardinal directions
    // (up, down, left, or right).
    // The first player to move the piece to the target position (tx, ty) wins.
    // We need to determine if the first player can win assuming optimal play.

    // This is an impartial game, and its outcome can be determined by the parity of the Manhattan distance
    // from the starting position to the target position.
    // The Manhattan distance from (0,0) to (tx, ty) is |tx| + |ty|.

    // Each valid move (one step up, down, left, or right) changes the Manhattan distance
    // from the current position to the target position by exactly 1.
    // For example, if the current position is (x, y) and the target is (tx, ty):
    // The distance is D = |tx - x| + |ty - y|.
    // If a player moves from (x, y) to (x+1, y):
    //   - If x < tx, then |tx - (x+1)| = |tx - x - 1| = |tx - x| - 1. Distance decreases by 1.
    //   - If x > tx, then |tx - (x+1)| = |tx - x - 1| = |x - tx| + 1. Distance increases by 1.
    //   - If x = tx, then |tx - (x+1)| = |-1| = 1. Distance increases by 1 (unless ty=y and this is the target).
    // In all cases, a single step changes the Manhattan distance by exactly 1.

    // Since each move changes the Manhattan distance by 1, it flips the parity of the distance.
    // The game ends when the distance is 0.
    // If the initial Manhattan distance `D = |tx| + |ty|` is odd:
    //   - After 1st player's move, distance becomes even.
    //   - After 2nd player's move, distance becomes odd.
    //   - ...
    //   - The player who makes the last move (when distance becomes 0) will have started their turn with an odd distance.
    //   - Thus, if the initial distance is odd, the first player will make the move that results in distance 0.
    // If the initial Manhattan distance `D = |tx| + |ty|` is even:
    //   - After 1st player's move, distance becomes odd.
    //   - After 2nd player's move, distance becomes even.
    //   - ...
    //   - The player who makes the last move will have started their turn with an odd distance.
    //   - Thus, if the initial distance is even, the second player will make the move that results in distance 0.

    // Therefore, the first player wins if and only if the initial Manhattan distance is odd.

    const manhattanDistance = Math.abs(tx) + Math.abs(ty);

    // The first player wins if the distance is odd.
    return manhattanDistance % 2 !== 0;
};