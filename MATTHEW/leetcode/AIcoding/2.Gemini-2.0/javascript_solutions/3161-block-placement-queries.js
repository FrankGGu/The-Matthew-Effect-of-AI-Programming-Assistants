var blockPlacementQueries = function(n, queries) {
    const result = [];
    for (const query of queries) {
        let l = query[0];
        let r = query[1];
        let k = query[2];

        let count = 0;
        for (let i = l; i <= r; i++) {
            if ((i + 1) % k === 0) {
                count++;
            }
        }
        result.push(count);
    }
    return result;
};