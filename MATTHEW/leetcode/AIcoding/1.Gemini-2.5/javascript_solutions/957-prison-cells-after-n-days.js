function prisonAfterNDays(cells, N) {
    if (N === 0) {
        return cells;
    }

    let currentCells = [...cells];
    currentCells = getNextState(currentCells);
    N--;

    let seenStates = new Map();

    for (let day = 0; day < N; day++) {
        let stateString = currentCells.join('');
        if (seenStates.has(stateString)) {
            let prevDay = seenStates.get(stateString);
            let cycleLength = day - prevDay;
            let remainingDays = N - day;
            let offsetInCycle = remainingDays % cycleLength;

            for (let i = 0; i < offsetInCycle; i++) {
                currentCells = getNextState(currentCells);
            }
            return currentCells;
        }

        seenStates.set(stateString, day);
        currentCells = getNextState(currentCells);
    }

    return currentCells;
}

function getNextState(cells) {
    let nextCells = new Array(cells.length).fill(0);
    for (let i = 1; i < cells.length - 1; i++) {
        if (cells[i - 1] === cells[i + 1]) {
            nextCells[i] = 1;
        } else {
            nextCells[i] = 0;
        }
    }
    return nextCells;
}