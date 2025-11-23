var minimumArea = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const ones = [];
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 1) {
                ones.push([r, c]);
            }
        }
    }

    if (ones.length === 0) {
        return 0;
    }

    function getBoundingBoxArea(points) {
        if (points.length === 0) {
            return 0;
        }
        let minR = Infinity, maxR = -Infinity;
        let minC = Infinity, maxC = -Infinity;
        for (const [r, c] of points) {
            minR = Math.min(minR, r);
            maxR = Math.max(maxR, r);
            minC = Math.min(minC, c);
            maxC = Math.max(maxC, c);
        }
        return (maxR - minR + 1) * (maxC - minC + 1);
    }

    function calculateMinAreaUpToTwoRects(points) {
        if (points.length === 0) {
            return 0;
        }
        let currentMinArea = getBoundingBoxArea(points);

        let minR = Infinity, maxR = -Infinity;
        let minC = Infinity, maxC = -Infinity;
        for (const [r, c] of points) {
            minR = Math.min(minR, r);
            maxR = Math.max(maxR, r);
            minC = Math.min(minC, c);
            maxC = Math.max(maxC, c);
        }

        for (let r_split = minR; r_split < maxR; r_split++) {
            let part1 = [];
            let part2 = [];
            for (const p of points) {
                if (p[0] <= r_split) {
                    part1.push(p);
                } else {
                    part2.push(p);
                }
            }
            currentMinArea = Math.min(currentMinArea, getBoundingBoxArea(part1) + getBoundingBoxArea(part2));
        }

        for (let c_split = minC; c_split < maxC; c_split++) {
            let part1 = [];
            let part2 = [];
            for (const p of points) {
                if (p[1] <= c_split) {
                    part1.push(p);
                } else {
                    part2.push(p);
                }
            }
            currentMinArea = Math.min(currentMinArea, getBoundingBoxArea(part1) + getBoundingBoxArea(part2));
        }
        return currentMinArea;
    }

    let minTotalArea = Infinity;

    let overallMinR = Infinity, overallMaxR = -Infinity;
    let overallMinC = Infinity, overallMaxC = -Infinity;
    for (const [r, c] of ones) {
        overallMinR = Math.min(overallMinR, r);
        overallMaxR = Math.max(overallMaxR, r);
        overallMinC = Math.min(overallMinC, c);
        overallMaxC = Math.max(overallMaxC, c);
    }

    // Case 1: One rectangle
    minTotalArea = Math.min(minTotalArea, getBoundingBoxArea(ones));

    // Case 2: Two rectangles (or 1 if it's better, handled by calculateMinAreaUpToTwoRects)
    minTotalArea = Math.min(minTotalArea, calculateMinAreaUpToTwoRects(ones));

    // Case 3: Three rectangles

    // Type A: Three horizontal strips
    for (let r_split1 = overallMinR; r_split1 < overallMaxR - 1; r_split1++) {
        for (let r_split2 = r_split1 + 1; r_split2 < overallMaxR; r_split2++) {
            let part1 = [];
            let part2 = [];
            let part3 = [];
            for (const p of ones) {
                if (p[0] <= r_split1) {
                    part1.push(p);
                } else if (p[0] <= r_split2) {
                    part2.push(p);
                } else {
                    part3.push(p);
                }
            }
            minTotalArea = Math.min(minTotalArea, getBoundingBoxArea(part1) + getBoundingBoxArea(part2) + getBoundingBoxArea(part3));
        }
    }

    // Type B: Three vertical strips
    for (let c_split1 = overallMinC; c_split1 < overallMaxC - 1; c_split1++) {
        for (let c_split2 = c_split1 + 1; c_split2 < overallMaxC; c_split2++) {
            let part1 = [];
            let part2 = [];
            let part3 = [];
            for (const p of ones) {
                if (p[1] <= c_split1) {
                    part1.push(p);
                } else if (p[1] <= c_split2) {
                    part2.push(p);
                } else {
                    part3.push(p);
                }
            }
            minTotalArea = Math.min(minTotalArea, getBoundingBoxArea(part1) + getBoundingBoxArea(part2) + getBoundingBoxArea(part3));
        }
    }

    // Type C: One horizontal split, then one of the parts split into up to two rectangles
    for (let r_split = overallMinR; r_split < overallMaxR; r_split++) {
        let top_part = [];
        let bottom_part = [];
        for (const p of ones) {
            if (p[0] <= r_split) {
                top_part.push(p);
            } else {
                bottom_part.push(p);
            }
        }
        minTotalArea = Math.min(minTotalArea, getBoundingBoxArea(top_part) + calculateMinAreaUpToTwoRects(bottom_part));
        minTotalArea = Math.min(minTotalArea, getBoundingBoxArea(bottom_part) + calculateMinAreaUpToTwoRects(top_part));
    }

    // Type D: One vertical split, then one of the parts split into up to two rectangles
    for (let c_split = overallMinC; c_split < overallMaxC; c_split++) {
        let left_part = [];
        let right_part = [];
        for (const p of ones) {
            if (p[1] <= c_split) {
                left_part.push(p);
            } else {
                right_part.push(p);
            }
        }
        minTotalArea = Math.min(minTotalArea, getBoundingBoxArea(left_part) + calculateMinAreaUpToTwoRects(right_part));
        minTotalArea = Math.min(minTotalArea, getBoundingBoxArea(right_part) + calculateMinAreaUpToTwoRects(left_part));
    }

    return minTotalArea;
};