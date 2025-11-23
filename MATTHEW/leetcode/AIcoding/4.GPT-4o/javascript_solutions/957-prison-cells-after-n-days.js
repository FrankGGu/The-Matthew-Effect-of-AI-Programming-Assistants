function prisonAfterNDays(cells, N) {
    const seen = new Map();
    const cycleLength = 14; // 14 days cycle
    N = N % cycleLength || cycleLength; // Get the effective number of days

    for (let i = 0; i < N; i++) {
        const nextCells = new Array(8).fill(0);
        for (let j = 1; j < 7; j++) {
            nextCells[j] = cells[j - 1] === cells[j + 1] ? 1 : 0;
        }
        cells = nextCells;
    }

    return cells;
}