var countMatchingSubarrays = function(nums, pattern) {
    const n = nums.length;
    const m = pattern.length;
    if (n <= m) return 0;

    const patternHash = computePatternHash(pattern);
    const numsPattern = new Array(n - 1);

    for (let i = 0; i < n - 1; i++) {
        if (nums[i + 1] > nums[i]) {
            numsPattern[i] = 1;
        } else if (nums[i + 1] === nums[i]) {
            numsPattern[i] = 0;
        } else {
            numsPattern[i] = -1;
        }
    }

    const prefix = new Array(n).fill(0);
    const base = 3;
    const mod = 1e9 + 7;
    let power = 1;

    for (let i = 0; i < n - 1; i++) {
        prefix[i + 1] = (prefix[i] * base + (numsPattern[i] + 1)) % mod;
        if (i < m) {
            power = (power * base) % mod;
        }
    }

    let res = 0;
    for (let i = m; i < n; i++) {
        const hash = (prefix[i] - prefix[i - m] * power % mod + mod) % mod;
        if (hash === patternHash) {
            res++;
        }
    }

    return res;
};

function computePatternHash(pattern) {
    const base = 3;
    const mod = 1e9 + 7;
    let hash = 0;
    for (const p of pattern) {
        hash = (hash * base + (p + 1)) % mod;
    }
    return hash;
}