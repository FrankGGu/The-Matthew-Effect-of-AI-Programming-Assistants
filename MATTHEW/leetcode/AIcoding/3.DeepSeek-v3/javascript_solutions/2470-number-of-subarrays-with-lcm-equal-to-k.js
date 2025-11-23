var subarrayLCM = function(nums, k) {
    let count = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        let currentLCM = nums[i];
        if (currentLCM === k) count++;
        for (let j = i + 1; j < n; j++) {
            currentLCM = lcm(currentLCM, nums[j]);
            if (currentLCM > k) break;
            if (currentLCM === k) count++;
        }
    }
    return count;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

function lcm(a, b) {
    return (a * b) / gcd(a, b);
}