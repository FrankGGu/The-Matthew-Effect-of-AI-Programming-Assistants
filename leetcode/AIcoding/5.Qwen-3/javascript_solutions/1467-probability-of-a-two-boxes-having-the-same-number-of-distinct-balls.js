function isPossible(nums, index, count, visited) {
    if (index === nums.length) {
        return true;
    }
    for (let i = 0; i < nums.length; i++) {
        if (visited[i]) continue;
        if (nums[i] === count) {
            visited[i] = true;
            if (isPossible(nums, index + 1, count, visited)) {
                return true;
            }
            visited[i] = false;
        }
    }
    return false;
}

function numberOfWays(nums) {
    const n = nums.length;
    let total = 0;
    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (nums[j] === nums[i]) {
                count++;
            }
        }
        if (count % 2 !== 0) {
            return 0;
        }
    }
    const visited = new Array(n).fill(false);
    for (let i = 0; i < n; i++) {
        if (visited[i]) continue;
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (nums[j] === nums[i]) {
                count++;
            }
        }
        if (count % 2 !== 0) {
            return 0;
        }
        for (let j = 0; j < n; j++) {
            if (nums[j] === nums[i]) {
                visited[j] = true;
            }
        }
    }
    return 1;
}

function numWays(arr) {
    const n = arr.length;
    const freq = {};
    for (const num of arr) {
        freq[num] = (freq[num] || 0) + 1;
    }
    for (const key in freq) {
        if (freq[key] % 2 !== 0) {
            return 0;
        }
    }
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    for (const key in freq) {
        const cnt = freq[key];
        for (let i = n; i >= 0; i--) {
            for (let j = 1; j <= cnt && i + j <= n; j += 2) {
                dp[i + j] += dp[i];
            }
        }
    }
    return dp[n];
}

function numberOfDistinctWays(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }
    const keys = Object.keys(freq);
    const dp = new Array(keys.length + 1).fill(0);
    dp[0] = 1;
    for (let i = 0; i < keys.length; i++) {
        const count = freq[keys[i]];
        for (let j = keys.length; j >= 0; j--) {
            for (let k = 1; k <= count && j + k <= keys.length; k += 2) {
                dp[j + k] += dp[j];
            }
        }
    }
    return dp[keys.length];
}

function probabilityOfSameDistinctBalls(nums) {
    const totalWays = numWays(nums);
    const distinctWays = numberOfDistinctWays(nums);
    return distinctWays / totalWays;
}