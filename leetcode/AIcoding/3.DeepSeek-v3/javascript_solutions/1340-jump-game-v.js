var maxJumps = function(arr, d) {
    const n = arr.length;
    const dp = new Array(n).fill(1);
    const stack = [];

    for (let i = 0; i <= n; i++) {
        while (stack.length && (i === n || arr[stack[stack.length - 1]] < arr[i])) {
            const mid = stack.pop();
            const left = stack.length ? stack[stack.length - 1] : -1;
            for (let j = i - 1; j > left && j >= mid - d; j--) {
                if (arr[j] < arr[mid]) {
                    dp[j] = Math.max(dp[j], dp[mid] + 1);
                }
            }
        }
        stack.push(i);
    }

    stack.length = 0;

    for (let i = n - 1; i >= -1; i--) {
        while (stack.length && (i === -1 || arr[stack[stack.length - 1]] < arr[i])) {
            const mid = stack.pop();
            const right = stack.length ? stack[stack.length - 1] : n;
            for (let j = i + 1; j < right && j <= mid + d; j++) {
                if (arr[j] < arr[mid]) {
                    dp[j] = Math.max(dp[j], dp[mid] + 1);
                }
            }
        }
        stack.push(i);
    }

    return Math.max(...dp);
};