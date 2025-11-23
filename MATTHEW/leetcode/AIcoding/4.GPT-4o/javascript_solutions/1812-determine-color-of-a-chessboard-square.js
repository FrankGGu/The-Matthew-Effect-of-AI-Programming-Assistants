var squareIsWhite = function(coordinates) {
    const column = coordinates.charCodeAt(0) - 'a'.charCodeAt(0);
    const row = parseInt(coordinates[1]) - 1;
    return (column + row) % 2 === 1;
};