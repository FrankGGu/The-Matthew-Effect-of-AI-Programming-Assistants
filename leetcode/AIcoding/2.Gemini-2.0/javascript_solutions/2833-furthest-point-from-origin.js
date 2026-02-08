var furthestDistanceFromOrigin = function(moves) {
    let leftRight = 0;
    let underscore = 0;

    for (let move of moves) {
        if (move === 'L') {
            leftRight--;
        } else if (move === 'R') {
            leftRight++;
        } else {
            underscore++;
        }
    }

    return Math.abs(leftRight) + underscore;
};