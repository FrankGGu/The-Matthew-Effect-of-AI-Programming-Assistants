var convert = function(s, numRows) {
    if (numRows === 1 || s.length <= numRows) {
        return s;
    }

    const rows = Array(numRows).fill('');
    let currentRow = 0;
    let goingDown = false;

    for (let i = 0; i < s.length; i++) {
        rows[currentRow] += s[i];

        if (currentRow === 0 || currentRow === numRows - 1) {
            goingDown = !goingDown;
        }

        if (goingDown) {
            currentRow++;
        } else {
            currentRow--;
        }
    }

    return rows.join('');
};