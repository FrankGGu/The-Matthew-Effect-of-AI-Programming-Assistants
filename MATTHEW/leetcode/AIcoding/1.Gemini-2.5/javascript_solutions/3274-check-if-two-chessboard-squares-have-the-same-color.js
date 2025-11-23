var squareIsSameColor = function(square1, square2) {
    let col1 = square1.charCodeAt(0) - 'a'.charCodeAt(0);
    let row1 = parseInt(square1[1]);

    let col2 = square2.charCodeAt(0) - 'a'.charCodeAt(0);
    let row2 = parseInt(square2[1]);

    let parity1 = (col1 + row1) % 2;
    let parity2 = (col2 + row2) % 2;

    return parity1 === parity2;
};