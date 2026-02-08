var getStrongest = function(arr, k) {
    arr.sort((a, b) => a - b);
    const mid = arr[Math.floor((arr.length - 1) / 2)];
    const strongest = arr.map(num => [Math.abs(num - mid), num]);
    strongest.sort((a, b) => b[0] - a[0] || b[1] - a[1]);
    return strongest.slice(0, k).map(item => item[1]);
};