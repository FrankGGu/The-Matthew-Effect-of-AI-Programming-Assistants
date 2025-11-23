function finalPositionOfSnake(matrix, moves) {
    let rows = matrix.length;
    let cols = matrix[0].length;
    let x = 0;
    let y = 0;
    for (let move of moves) {
        if (move === "UP") {
            x--;
        } else if (move === "DOWN") {
            x++;
        } else if (move === "LEFT") {
            y--;
        } else if (move === "RIGHT") {
            y++;
        }
    }
    return [x, y];
}