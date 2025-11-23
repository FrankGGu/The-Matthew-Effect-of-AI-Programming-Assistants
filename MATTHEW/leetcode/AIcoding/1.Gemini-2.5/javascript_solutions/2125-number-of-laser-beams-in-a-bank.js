var numberOfBeams = function(bank) {
    let totalBeams = 0;
    let prevRowCount = 0;

    for (let i = 0; i < bank.length; i++) {
        let currentRowCount = 0;
        for (let j = 0; j < bank[i].length; j++) {
            if (bank[i][j] === '1') {
                currentRowCount++;
            }
        }

        if (currentRowCount > 0) {
            totalBeams += prevRowCount * currentRowCount;
            prevRowCount = currentRowCount;
        }
    }

    return totalBeams;
};