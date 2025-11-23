function subarrayGCD(nums, k) {
    let count = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        let gcd = 0;
        for (let j = i; j < n; j++) {
            gcd = getGCD(gcd, nums[j]);
            if (gcd < k) break;
            if (gcd === k) count++;
        }
    }

    return count;
}

function getGCD(a, b) {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
}