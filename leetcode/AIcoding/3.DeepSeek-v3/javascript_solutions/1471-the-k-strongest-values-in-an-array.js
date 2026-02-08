var getStrongest = function(arr, k) {
    arr.sort((a, b) => a - b);
    const n = arr.length;
    const m = arr[Math.floor((n - 1) / 2)];

    arr.sort((a, b) => {
        const diffA = Math.abs(a - m);
        const diffB = Math.abs(b - m);
        if (diffA !== diffB) {
            return diffB - diffA;
        } else {
            return b - a;
        }
    });

    return arr.slice(0, k);
};