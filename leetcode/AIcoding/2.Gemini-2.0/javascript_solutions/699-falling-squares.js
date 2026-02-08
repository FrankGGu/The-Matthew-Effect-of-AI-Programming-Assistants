var fallingSquares = function(positions) {
    const n = positions.length;
    const heights = [];
    const result = [];
    let maxHeight = 0;

    for (let i = 0; i < n; i++) {
        const [left, side] = positions[i];
        const right = left + side;
        let currentHeight = side;

        for (let j = 0; j < heights.length; j++) {
            const [existingLeft, existingRight, existingHeight] = heights[j];

            if (right > existingLeft && left < existingRight) {
                currentHeight = Math.max(currentHeight, existingHeight + side);
            }
        }

        heights.push([left, right, side]);

        let overlapHeight = side;
        for (let j = 0; j < heights.length - 1; j++) {
            const [existingLeft, existingRight, existingHeight] = heights[j];

            if (right > existingLeft && left < existingRight) {
                overlapHeight = Math.max(overlapHeight, existingHeight + side);
            }
        }

        maxHeight = 0;
         for (let k = 0; k <= i; k++) {
            const [currLeft, currRight, currSide] = positions[k];
            let tempHeight = currSide;
            for(let l = 0; l < k; l++) {
                const [prevLeft, prevRight, prevSide] = positions[l];
                if (currRight > prevLeft && currLeft < prevRight) {
                    let prevMaxHeight = prevSide;
                    for (let m = 0; m < l; m++) {
                        const [olderLeft, olderRight, olderSide] = positions[m];
                        if (prevRight > olderLeft && prevLeft < olderRight) {
                             prevMaxHeight = Math.max(prevMaxHeight, heights[m][2] + prevSide);
                        }
                    }
                    tempHeight = Math.max(tempHeight, prevMaxHeight + currSide);
                }
            }
             maxHeight = Math.max(maxHeight, tempHeight);
        }

        result.push(maxHeight);
    }

    return result;
};