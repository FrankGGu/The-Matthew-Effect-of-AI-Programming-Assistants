function countServers(servers) {
    const rowCount = servers.length;
    const colCount = servers[0].length;
    const rowSum = new Array(rowCount).fill(0);
    const colSum = new Array(colCount).fill(0);

    for (let i = 0; i < rowCount; i++) {
        for (let j = 0; j < colCount; j++) {
            if (servers[i][j] === 1) {
                rowSum[i]++;
                colSum[j]++;
            }
        }
    }

    let count = 0;
    for (let i = 0; i < rowCount; i++) {
        for (let j = 0; j < colCount; j++) {
            if (servers[i][j] === 1 && rowSum[i] === 1 && colSum[j] === 1) {
                count++;
            }
        }
    }

    return count;
}