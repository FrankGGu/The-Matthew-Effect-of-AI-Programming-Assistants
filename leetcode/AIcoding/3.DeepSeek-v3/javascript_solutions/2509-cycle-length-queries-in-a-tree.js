var cycleLengthQueries = function(n, queries) {
    const result = [];
    for (const [a, b] of queries) {
        let x = a, y = b;
        let depthX = Math.floor(Math.log2(x));
        let depthY = Math.floor(Math.log2(y));
        let steps = 0;

        while (x !== y) {
            if (x > y) {
                x = Math.floor(x / 2);
                steps++;
            } else {
                y = Math.floor(y / 2);
                steps++;
            }
        }
        result.push(steps + 1);
    }
    return result;
};