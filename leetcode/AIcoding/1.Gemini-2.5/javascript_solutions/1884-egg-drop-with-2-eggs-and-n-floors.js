var twoEggDrop = function(n) {
    let moves = 0;
    let floorsCovered = 0;
    while (floorsCovered < n) {
        moves++;
        floorsCovered += moves;
    }
    return moves;
};