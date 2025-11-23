var squareIsWhite = function(coordinates) {
    const col = coordinates.charCodeAt(0) - 'a'.charCodeAt(0) + 1;
    const row = parseInt(coordinates[1]);
    return (col + row) % 2 === 1;
};