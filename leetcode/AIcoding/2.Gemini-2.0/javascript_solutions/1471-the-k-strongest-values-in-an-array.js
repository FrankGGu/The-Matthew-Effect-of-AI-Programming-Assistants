var getStrongest = function(arr, k) {
    arr.sort((a, b) => a - b);
    const median = arr[Math.floor((arr.length - 1) / 2)];
    arr.sort((a, b) => Math.abs(a - median) - Math.abs(b - median) || b - a);
    return arr.slice(0, k);
};