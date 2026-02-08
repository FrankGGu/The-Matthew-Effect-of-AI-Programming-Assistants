var canArrange = function(arr, k) {
    const remainders = new Array(k).fill(0);
    for (const num of arr) {
        const remainder = (num % k + k) % k;
        remainders[remainder]++;
    }

    if (remainders[0] % 2 !== 0) {
        return false;
    }

    for (let i = 1; i <= k / 2; i++) {
        if (remainders[i] !== remainders[k - i]) {
            return false;
        }
    }

    return true;
};