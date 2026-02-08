function furthestDistanceFromOrigin(moves) {
    let left = 0, right = 0, blank = 0;

    for (const move of moves) {
        if (move === 'L') left++;
        else if (move === 'R') right++;
        else blank++;
    }

    const netMoves = Math.abs(left - right);
    return netMoves + blank;
}