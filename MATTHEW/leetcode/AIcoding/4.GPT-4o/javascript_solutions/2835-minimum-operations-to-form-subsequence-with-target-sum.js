var minOperations = function(target, arr) {
    const set = new Set(arr);
    const dp = Array(arr.length + 1).fill(0);
    let len = 0;

    for (let num of set) {
        if (num === target) return 1;
        if (num < target) {
            let left = 0, right = len;
            while (left < right) {
                const mid = Math.floor((left + right) / 2);
                if (dp[mid] < num) left = mid + 1;
                else right = mid;
            }
            dp[left] = num;
            if (left === len) len++;
        }
    }

    return arr.length - len;
};