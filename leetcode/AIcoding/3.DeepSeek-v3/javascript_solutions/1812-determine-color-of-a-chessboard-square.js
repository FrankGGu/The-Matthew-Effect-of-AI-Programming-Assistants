var squareIsWhite = function(coordinates) {
    const letter = coordinates[0].charCodeAt(0) - 'a'.charCodeAt(0);
    const number = parseInt(coordinates[1]);
    return (letter + number) % 2 !== 0;
};