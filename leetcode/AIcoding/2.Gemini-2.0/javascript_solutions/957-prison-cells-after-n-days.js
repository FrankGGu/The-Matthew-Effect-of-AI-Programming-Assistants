var prisonAfterNDays = function(cells, n) {
    const seen = new Map();
    let currentCells = [...cells];

    for (let i = 0; i < n; i++) {
        const key = currentCells.join(',');
        if (seen.has(key)) {
            const cycleLength = i - seen.get(key);
            const remainingDays = (n - i) % cycleLength;
            for (let j = 0; j < remainingDays; j++) {
                let nextCells = new Array(cells.length).fill(0);
                for (let k = 1; k < cells.length - 1; k++) {
                    if (currentCells[k - 1] === currentCells[k + 1]) {
                        nextCells[k] = 1;
                    }
                }
                currentCells = nextCells;
            }
            return currentCells;
        }

        seen.set(key, i);
        let nextCells = new Array(cells.length).fill(0);
        for (let j = 1; j < cells.length - 1; j++) {
            if (currentCells[j - 1] === currentCells[j + 1]) {
                nextCells[j] = 1;
            }
        }
        currentCells = nextCells;
    }

    return currentCells;
};