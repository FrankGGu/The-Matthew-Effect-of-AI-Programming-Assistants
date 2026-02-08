var furthestDistanceFromOrigin = function(moves) {
    let leftCount = 0;
    let rightCount = 0;
    let underscoreCount = 0;

    for (let i = 0; i < moves.length; i++) {
        if (moves[i] === 'L') {
            leftCount++;
        } else if (moves[i] === 'R') {
            rightCount++;
        } else {
            underscoreCount++;
        }
    }

    let initialDisplacement = rightCount - leftCount;

    // To maximize positive distance, treat all '_' as 'R'
    let maxPositivePosition = initialDisplacement + underscoreCount;

    // To maximize negative distance (i.e., furthest left), treat all '_' as 'L'
    let maxNegativePosition = initialDisplacement - underscoreCount;

    return Math.max(Math.abs(maxPositivePosition), Math.abs(maxNegativePosition));
};