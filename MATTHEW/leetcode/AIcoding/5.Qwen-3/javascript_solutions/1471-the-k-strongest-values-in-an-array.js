function getStrongest(arr, k) {
    arr.sort((a, b) => a - b);
    const n = arr.length;
    const median = arr[Math.floor((n - 1) / 2)];
    arr.sort((a, b) => Math.abs(b - median) - Math.abs(a - median) || b - a);
    return arr.slice(0, k);
}