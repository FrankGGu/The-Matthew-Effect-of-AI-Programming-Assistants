var maxValueSum = function(board) {
    const m = board.length;
    const n = board[0].length;
    let maxSum = -Infinity;

    for (let i1 = 0; i1 < m; i1++) {
        for (let j1 = 0; j1 < n; j1++) {
            for (let i2 = i1; i2 < m; i2++) {
                for (let j2 = (i2 === i1 ? j1 + 1 : 0); j2 < n; j2++) {
                    for (let i3 = i2; i3 < m; i3++) {
                        for (let j3 = (i3 === i2 ? j2 + 1 : 0); j3 < n; j3++) {
                            let sum = board[i1][j1] + board[i2][j2] + board[i3][j3];
                            if (i1 === i2 && i2 === i3) {
                                sum += board[i1][j1] + board[i2][j2] + board[i3][j3];
                            } else if (i1 === i2) {
                                sum += board[i1][j1] + board[i2][j2];
                            } else if (i2 === i3) {
                                sum += board[i2][j2] + board[i3][j3];
                            } else if (i1 === i3) {
                                sum += board[i1][j1] + board[i3][j3];
                            }
                            maxSum = Math.max(maxSum, sum);
                        }
                    }
                }
            }
        }
    }

    return maxSum;
};