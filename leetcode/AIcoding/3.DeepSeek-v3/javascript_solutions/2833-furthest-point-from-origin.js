var furthestDistanceFromOrigin = function(moves) {
    let left = 0, right = 0, underscore = 0;
    for (const move of moves) {
        if (move === 'L') left++;
        else if (move === 'R') right++;
        else underscore++;
    }
    return Math.abs(left - right) + underscore;
};