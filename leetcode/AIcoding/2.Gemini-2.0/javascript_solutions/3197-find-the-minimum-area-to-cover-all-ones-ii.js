var minArea = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    const rows = matrix.length;
    const cols = matrix[0].length;
    let ones = [];
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (matrix[i][j] === 1) {
                ones.push([i, j]);
            }
        }
    }

    if (ones.length === 0) {
        return 0;
    }

    let minArea = Infinity;

    function solve(onesRemaining, currentRectangles, area) {
        if (onesRemaining.length === 0) {
            minArea = Math.min(minArea, area);
            return;
        }

        if (area >= minArea) return;

        let one = onesRemaining[0];
        let newOnesRemaining = onesRemaining.slice(1);

        for (let i = 0; i < currentRectangles.length; i++) {
            let rect = currentRectangles[i];
            if (one[0] >= rect[0] && one[0] <= rect[2] && one[1] >= rect[1] && one[1] <= rect[3]) {
                solve(newOnesRemaining, currentRectangles, area);
                return;
            }
        }

        for (let r = one[0]; r < rows; r++) {
            for (let c = one[1]; c < cols; c++) {
                let newRect = [one[0], one[1], r, c];
                let newOnesLeft = [];
                let allCovered = true;
                for (let j = 0; j < onesRemaining.length; j++) {
                    let otherOne = onesRemaining[j];
                    if (otherOne[0] >= newRect[0] && otherOne[0] <= newRect[2] && otherOne[1] >= newRect[1] && otherOne[1] <= newRect[3]) {
                        continue;
                    } else {
                        newOnesLeft.push(otherOne);
                        allCovered = false;
                    }
                }
                if(allCovered){
                    solve([], currentRectangles.concat([newRect]), area + (newRect[2] - newRect[0] + 1) * (newRect[3] - newRect[1] + 1));
                } else {
                     solve(newOnesLeft, currentRectangles.concat([newRect]), area + (newRect[2] - newRect[0] + 1) * (newRect[3] - newRect[1] + 1));
                }
            }
        }
    }

    solve(ones, [], 0);

    return minArea;
};