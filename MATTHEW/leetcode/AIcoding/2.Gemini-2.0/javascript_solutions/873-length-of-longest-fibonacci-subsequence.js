var lenLongestFibSubseq = function(arr) {
    const n = arr.length;
    const index = new Map();
    for (let i = 0; i < n; i++) {
        index.set(arr[i], i);
    }

    let longest = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let a = arr[i];
            let b = arr[j];
            let length = 2;

            while (index.has(a + b)) {
                const next = a + b;
                a = b;
                b = next;
                length++;
            }

            longest = Math.max(longest, length);
        }
    }

    return longest > 2 ? longest : 0;
};