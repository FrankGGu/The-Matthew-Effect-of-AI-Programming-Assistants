var convert = function(s, numRows) {
    if (numRows === 1 || numRows >= s.length) return s;
    let rows = Array.from({ length: Math.min(numRows, s.length) }, () => "");
    let currRow = 0;
    let goingDown = false;

    for (let char of s) {
        rows[currRow] += char;
        if (currRow === 0 || currRow === numRows - 1) goingDown = !goingDown;
        currRow += goingDown ? 1 : -1;
    }

    return rows.join("");
};