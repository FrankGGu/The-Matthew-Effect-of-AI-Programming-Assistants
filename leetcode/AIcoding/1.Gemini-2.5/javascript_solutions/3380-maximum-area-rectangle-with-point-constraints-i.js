var maximumArea = function(points, k) {
    let xCoordsSet = new Set();
    for (let p of points) {
        xCoordsSet.add(p[0]);
    }
    let sortedX = Array.from(xCoordsSet).sort((a, b) => a - b);

    let maxArea = 0;

    for (let i = 0; i < sortedX.length; i++) {
        let x1 = sortedX[i];
        for (let j = i; j < sortedX.length; j++) {
            let x2 = sortedX[j];

            let currentYValues = [];
            for (let p of points) {
                if (p[0] >= x1 && p[0] <= x2) {
                    currentYValues.push(p[1]);
                }
            }

            if (currentYValues.length < k) {
                continue;
            }

            currentYValues.sort((a, b) => a - b);

            for (let l = 0; l <= currentYValues.length - k; l++) {
                let y1 = currentYValues[l];
                let y2 = currentYValues[l + k - 1];

                let width = x2 - x1;
                let height = y2 - y1;

                maxArea = Math.max(maxArea, width * height);
            }
        }
    }

    return maxArea;
};