function canArrange(arr, k) {
    const remainderCount = Array(k).fill(0);

    for (const num of arr) {
        const remainder = ((num % k) + k) % k;
        remainderCount[remainder]++;
    }

    if (remainderCount[0] % 2 !== 0) return false;

    for (let i = 1; i < k; i++) {
        if (remainderCount[i] !== remainderCount[k - i]) return false;
    }

    return true;
}