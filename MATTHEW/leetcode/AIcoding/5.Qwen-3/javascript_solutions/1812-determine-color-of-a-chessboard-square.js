var squareIsWhiteLetter = function(coordinates) {
    const [letter, number] = coordinates;
    const col = letter.charCodeAt(0) - 'a'.charCodeAt(0);
    const row = parseInt(number, 10);
    return (col + row) % 2 === 1;
};