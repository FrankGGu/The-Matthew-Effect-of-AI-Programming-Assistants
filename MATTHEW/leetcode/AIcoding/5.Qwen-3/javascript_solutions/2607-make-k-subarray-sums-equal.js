function canMakeKSubarraySumsEqual(arr, k) {
    const n = arr.length;
    if (n % k !== 0) return false;

    const target = Math.floor(n / k);
    const freq = {};

    for (let i = 0; i < n; i += k) {
        const sub = arr.slice(i, i + target);
        const key = sub.join(',');
        freq[key] = (freq[key] || 0) + 1;
    }

    const values = Object.values(freq);
    const max = Math.max(...values);
    const min = Math.min(...values);

    return max === min;
}