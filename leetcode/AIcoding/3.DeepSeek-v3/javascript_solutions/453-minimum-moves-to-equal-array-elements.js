var minMoves = function(nums) {
    let min = Math.min(...nums);
    let moves = 0;
    for (let num of nums) {
        moves += num - min;
    }
    return moves;
};