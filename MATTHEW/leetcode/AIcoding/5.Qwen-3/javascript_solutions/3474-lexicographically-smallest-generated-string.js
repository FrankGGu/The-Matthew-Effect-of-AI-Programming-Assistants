function getSmallestString(n, k) {
    const arr = new Array(n).fill(1);
    let remaining = k - n;
    for (let i = n - 1; i >= 0 && remaining > 0; i--) {
        const add = Math.min(25, remaining);
        arr[i] += add;
        remaining -= add;
    }
    return arr.map(c => String.fromCharCode(96 + c)).join('');
}