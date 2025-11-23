var findMaximumNumber = function(k, x) {
    let left = 1;
    let right = 1e15;
    let result = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const sum = calculateSum(mid, x);
        if (sum <= k) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
};

function calculateSum(num, x) {
    let sum = 0;
    for (let i = 0; i < 60; i++) {
        const bit = i + 1;
        if (bit % x !== 0) continue;
        const fullCycles = Math.floor(num / (1n << BigInt(bit)));
        const remainder = num % (1n << BigInt(bit));
        const count = fullCycles * (1n << BigInt(bit - 1)) + Math.max(0n, remainder - (1n << BigInt(bit - 1)) + 1n);
        sum += Number(count);
    }
    return sum;
}