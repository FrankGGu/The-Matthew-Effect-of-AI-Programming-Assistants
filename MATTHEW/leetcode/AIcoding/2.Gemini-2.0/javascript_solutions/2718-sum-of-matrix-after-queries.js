var sumOfMatrixAfterQueries = function(n, queries) {
    let row = new Array(n).fill(0);
    let col = new Array(n).fill(0);
    let rowCnt = 0;
    let colCnt = 0;
    let sum = 0;

    for (let i = queries.length - 1; i >= 0; i--) {
        let type = queries[i][0];
        let index = queries[i][1];
        let val = queries[i][2];

        if (type === 0) {
            if (row[index] === 0) {
                row[index] = 1;
                rowCnt++;
                for (let j = 0; j < n; j++) {
                    if (col[j] === 0) {
                        sum += val;
                    }
                }
            }
        } else {
            if (col[index] === 0) {
                col[index] = 1;
                colCnt++;
                for (let j = 0; j < n; j++) {
                    if (row[j] === 0) {
                        sum += val;
                    }
                }
            }
        }

        if (rowCnt === n && colCnt === n) break;
    }

    return sum;
};