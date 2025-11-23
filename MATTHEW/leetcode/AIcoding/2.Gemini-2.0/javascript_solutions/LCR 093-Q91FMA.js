var lenLongestFibSubseq = function(arr) {
    const n = arr.length;
    const index = new Map();
    for (let i = 0; i < n; i++) {
        index.set(arr[i], i);
    }
    const dp = new Map();
    let ans = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let a = arr[i];
            let b = arr[j];
            let len = 2;
            let next = a + b;
            while (index.has(next)) {
                len++;
                const nextIndex = index.get(next);
                a = b;
                b = next;
                next = a + b;
            }
            ans = Math.max(ans, len);
        }
    }
    return ans > 2 ? ans : 0;
};