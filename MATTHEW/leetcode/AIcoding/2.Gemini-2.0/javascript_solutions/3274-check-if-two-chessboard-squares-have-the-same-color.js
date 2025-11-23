var squareIsWhite = function(coordinates) {
    const charCodeA = 'a'.charCodeAt(0);
    const file = coordinates.charCodeAt(0) - charCodeA + 1;
    const rank = parseInt(coordinates[1]);
    return (file + rank) % 2 !== 0;
};