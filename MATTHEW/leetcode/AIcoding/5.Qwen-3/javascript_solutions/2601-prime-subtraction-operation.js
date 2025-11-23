function primeSubtractionOperation(nums) {
    const maxNum = Math.max(...nums);
    const isPrime = new Array(maxNum + 1).fill(true);
    isPrime[0] = isPrime[1] = false;
    for (let i = 2; i * i <= maxNum; i++) {
        if (isPrime[i]) {
            for (let j = i * i; j <= maxNum; j += i) {
                isPrime[j] = false;
            }
        }
    }

    let prev = Infinity;
    for (let i = nums.length - 1; i >= 0; i--) {
        let found = false;
        for (let p = 2; p <= nums[i]; p++) {
            if (isPrime[p] && nums[i] - p < prev) {
                prev = nums[i] - p;
                found = true;
                break;
            }
        }
        if (!found) return false;
    }
    return true;
}