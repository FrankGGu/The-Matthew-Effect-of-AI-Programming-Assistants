function numberOfLaserBeams(bank) {
    let prev = 0;
    let result = 0;

    for (const row of bank) {
        let count = 0;
        for (const cell of row) {
            if (cell === '1') count++;
        }
        if (count > 0) {
            result += prev * count;
            prev = count;
        }
    }

    return result;
}