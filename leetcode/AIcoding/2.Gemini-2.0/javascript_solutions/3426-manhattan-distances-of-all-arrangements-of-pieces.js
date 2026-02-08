var manhattanDistances = function(pieces, locations) {
    const n = pieces.length;
    const m = locations.length;
    const result = new Array(m).fill(0);

    function permute(arr, l, r) {
        if (l === r) {
            for (let i = 0; i < m; i++) {
                let dist = 0;
                for (let j = 0; j < n; j++) {
                    dist += Math.abs(pieces[arr[j]][0] - locations[i][0]) + Math.abs(pieces[arr[j]][1] - locations[i][1]);
                }
                result[i] += dist;
            }
        } else {
            for (let i = l; i <= r; i++) {
                [arr[l], arr[i]] = [arr[i], arr[l]];
                permute(arr, l + 1, r);
                [arr[l], arr[i]] = [arr[i], arr[l]]; // backtrack
            }
        }
    }

    const indices = Array.from({ length: n }, (_, i) => i);
    permute(indices, 0, n - 1);

    let factorialN = 1;
    for (let i = 1; i <= n; i++) {
        factorialN *= i;
    }

    return result.map(dist => dist / factorialN);
};