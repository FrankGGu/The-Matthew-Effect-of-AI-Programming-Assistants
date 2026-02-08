var getKth = function(lo, hi, k) {
    const power = (n) => {
        let steps = 0;
        while (n !== 1) {
            n = n % 2 === 0 ? n / 2 : 3 * n + 1;
            steps++;
        }
        return steps;
    };

    const arr = [];
    for (let i = lo; i <= hi; i++) {
        arr.push([power(i), i]);
    }

    arr.sort((a, b) => a[0] === b[0] ? a[1] - b[1] : a[0] - b[0]);

    return arr[k - 1][1];
};