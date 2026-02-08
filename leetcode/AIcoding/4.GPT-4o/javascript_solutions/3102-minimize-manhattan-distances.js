var minTotalDistance = function(grid) {
    const getMedian = (arr) => {
        arr.sort((a, b) => a - b);
        const mid = Math.floor(arr.length / 2);
        return arr.length % 2 === 0 ? (arr[mid - 1] + arr[mid]) / 2 : arr[mid];
    };

    const rows = [];
    const cols = [];

    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[0].length; j++) {
            if (grid[i][j] === 1) {
                rows.push(i);
                cols.push(j);
            }
        }
    }

    const rowMedian = getMedian(rows);
    const colMedian = getMedian(cols);

    let distance = 0;
    for (let i = 0; i < rows.length; i++) {
        distance += Math.abs(rows[i] - rowMedian) + Math.abs(cols[i] - colMedian);
    }

    return distance;
};