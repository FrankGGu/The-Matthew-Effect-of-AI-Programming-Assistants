function subarraysWithGCD(nums, k) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        let currentGCD = nums[i];
        if (currentGCD === k) count++;
        for (let j = i + 1; j < nums.length; j++) {
            currentGCD = gcd(currentGCD, nums[j]);
            if (currentGCD === k) count++;
            else if (currentGCD < k) break;
        }
    }
    return count;
}

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}