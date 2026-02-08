var minSwapsCouples = function(row) {
    const n = row.length / 2;
    const pos = new Array(n).fill(0).map((_, i) => i);
    const partner = new Array(n).fill(0);

    for (let i = 0; i < row.length; i++) {
        partner[row[i] / 2] = row[i] % 2 === 0 ? row[i] + 1 : row[i] - 1;
    }

    let swaps = 0;
    const visited = new Array(n).fill(false);

    for (let i = 0; i < n; i++) {
        if (visited[i] || partner[i] === i * 2 || partner[i] === i * 2 + 1) {
            continue;
        }
        let cycleSize = 0;
        let j = i;

        while (!visited[j]) {
            visited[j] = true;
            j = partner[j] / 2;
            cycleSize++;
        }
        if (cycleSize > 0) {
            swaps += cycleSize - 1;
        }
    }

    return swaps;
};