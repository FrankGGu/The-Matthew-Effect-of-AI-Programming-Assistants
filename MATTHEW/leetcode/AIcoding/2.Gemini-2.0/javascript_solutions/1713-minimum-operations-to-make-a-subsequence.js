var minOperations = function(target, arr) {
    const n = target.length;
    const m = arr.length;
    const targetMap = new Map();
    for (let i = 0; i < n; i++) {
        targetMap.set(target[i], i);
    }

    const sub = [];
    for (let i = 0; i < m; i++) {
        if (targetMap.has(arr[i])) {
            sub.push(targetMap.get(arr[i]));
        }
    }

    if (sub.length === 0) {
        return n;
    }

    const tails = [];
    for (const num of sub) {
        if (tails.length === 0 || num > tails[tails.length - 1]) {
            tails.push(num);
        } else {
            let left = 0;
            let right = tails.length - 1;
            while (left < right) {
                const mid = Math.floor((left + right) / 2);
                if (tails[mid] < num) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            tails[left] = num;
        }
    }

    return n - tails.length;
};