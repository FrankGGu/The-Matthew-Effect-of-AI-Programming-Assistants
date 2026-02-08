var getStrongest = function(arr, k) {
    arr.sort((a, b) => a - b);

    const n = arr.length;
    const m = arr[Math.floor((n - 1) / 2)];

    arr.sort((a, b) => {
        const strengthA = Math.abs(a - m);
        const strengthB = Math.abs(b - m);

        if (strengthA === strengthB) {
            return b - a;
        }
        return strengthB - strengthA;
    });

    return arr.slice(0, k);
};