function findTheArrayConcVal(nums) {
    let n = nums.length;
    let total = 0;
    for (let i = 0; i < Math.floor(n / 2); i++) {
        total += Number(`${nums[i]}${nums[n - 1 - i]}`);
    }
    if (n % 2 === 1) {
        total += nums[Math.floor(n / 2)];
    }
    return total;
}