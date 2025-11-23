var minSwapsCouples = function(row) {
    let n = row.length;
    let ans = 0;
    for (let i = 0; i < n; i += 2) {
        let x = row[i];
        let y = x % 2 === 0 ? x + 1 : x - 1;
        if (row[i + 1] !== y) {
            ans++;
            for (let j = i + 1; j < n; j++) {
                if (row[j] === y) {
                    row[j] = row[i + 1];
                    row[i + 1] = y;
                    break;
                }
            }
        }
    }
    return ans;
};