function subarrayLCM(nums, k) {
    let count = 0;

    for (let i = 0; i < nums.length; i++) {
        let lcm = 1;
        for (let j = i; j < nums.length; j++) {
            lcm = (lcm * nums[j]) / gcd(lcm, nums[j]);
            if (lcm === k) count++;
            if (lcm > k) break;
        }
    }

    return count;
}

function gcd(a, b) {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
}