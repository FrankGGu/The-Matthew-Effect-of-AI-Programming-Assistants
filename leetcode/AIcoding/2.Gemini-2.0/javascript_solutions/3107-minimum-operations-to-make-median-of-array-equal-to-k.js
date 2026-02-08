var minOperations = function(nums, k) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let medianIndex = Math.floor(n / 2);
    let target = nums[medianIndex];

    if (target === k) {
        return 0;
    }

    let smaller = 0;
    let larger = 0;

    for (let i = 0; i < n; i++) {
        if (nums[i] < k) {
            smaller++;
        } else if (nums[i] > k) {
            larger++;
        }
    }

    if (n % 2 === 0) {
        if (smaller >= n / 2 && larger >= n / 2) {
            return 1;
        } else if (smaller < n / 2) {
            return n / 2 - smaller;
        } else {
            return n / 2 - (n - larger);
        }
    } else {
        if (smaller >= (n + 1) / 2 - 1 && larger >= (n + 1) / 2 - 1) {
            return 1;
        } else if (smaller < (n + 1) / 2 - 1) {
            return (n + 1) / 2 - 1 - smaller;
        } else {
            return (n + 1) / 2 - 1 - (n - larger - 1);
        }
    }
};