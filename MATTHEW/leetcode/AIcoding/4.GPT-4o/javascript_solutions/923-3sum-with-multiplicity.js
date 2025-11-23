var threeSumMulti = function(arr, target) {
    const mod = 1e9 + 7;
    const count = new Map();
    let result = 0;

    for (let num of arr) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    const uniqueNums = Array.from(count.keys()).sort((a, b) => a - b);

    for (let i = 0; i < uniqueNums.length; i++) {
        for (let j = i; j < uniqueNums.length; j++) {
            const k = target - uniqueNums[i] - uniqueNums[j];
            if (k < uniqueNums[j]) continue;

            if (count.has(k)) {
                if (i === j && j === uniqueNums.indexOf(k)) {
                    const c = count.get(uniqueNums[i]);
                    result = (result + (c * (c - 1) * (c - 2)) / 6) % mod;
                } else if (i === j) {
                    const c1 = count.get(uniqueNums[i]);
                    const c2 = count.get(k);
                    result = (result + (c1 * (c1 - 1) / 2 * c2) % mod) % mod;
                } else if (j === uniqueNums.indexOf(k)) {
                    const c1 = count.get(uniqueNums[j]);
                    const c2 = count.get(uniqueNums[i]);
                    result = (result + (c2 * (c2 - 1) / 2 * c1) % mod) % mod;
                } else {
                    const c1 = count.get(uniqueNums[i]);
                    const c2 = count.get(uniqueNums[j]);
                    const c3 = count.get(k);
                    result = (result + (c1 * c2 * c3) % mod) % mod;
                }
            }
        }
    }

    return result;
};