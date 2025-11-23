function canBeDivisible(nums, k) {
    const remainderCount = new Array(k).fill(0);

    for (const num of nums) {
        const rem = num % k;
        remainderCount[rem]++;
    }

    if (remainderCount[0] % 2 !== 0) return false;

    for (let i = 1; i < k; i++) {
        if (remainderCount[i] !== remainderCount[k - i]) return false;
    }

    return true;
}