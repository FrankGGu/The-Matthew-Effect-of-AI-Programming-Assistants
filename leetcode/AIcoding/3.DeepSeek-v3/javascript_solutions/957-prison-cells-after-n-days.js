var prisonAfterNDays = function(cells, N) {
    let seen = new Map();
    let isFastForwarded = false;

    while (N > 0) {
        if (!isFastForwarded) {
            let key = cells.join('');
            if (seen.has(key)) {
                N %= seen.get(key) - N;
                isFastForwarded = true;
            } else {
                seen.set(key, N);
            }
        }

        if (N > 0) {
            N--;
            cells = nextDay(cells);
        }
    }

    return cells;
};

function nextDay(cells) {
    let newCells = new Array(8).fill(0);
    for (let i = 1; i < 7; i++) {
        newCells[i] = cells[i-1] === cells[i+1] ? 1 : 0;
    }
    return newCells;
}