var numberOfWays = function(points) {
    points.sort((a, b) => {
        if (a[0] === b[0]) {
            return a[1] - b[1];
        }
        return a[0] - b[0];
    });

    let count = 0;
    for (let i = 0; i < points.length; i++) {
        for (let j = i + 1; j < points.length; j++) {
            if (points[i][1] <= points[j][1]) {
                let valid = true;
                for (let k = 0; k < points.length; k++) {
                    if (k !== i && k !== j) {
                        if ((points[k][0] >= points[i][0] && points[k][0] <= points[j][0]) &&
                            (points[k][1] > points[i][1] && points[k][1] < points[j][1])) {
                            valid = false;
                            break;
                        }
                    }
                }
                if (valid) {
                    count++;
                }
            }
        }
    }

    return count;
};