function squareIsWhite(coordinates) {
    const [x1, y1] = coordinates[0].charCodeAt(0) - 'a'.charCodeAt(0);
    const [x2, y2] = coordinates[1].charCodeAt(0) - 'a'.charCodeAt(0);
    return (x1 + y1) % 2 !== (x2 + y2) % 2;
}