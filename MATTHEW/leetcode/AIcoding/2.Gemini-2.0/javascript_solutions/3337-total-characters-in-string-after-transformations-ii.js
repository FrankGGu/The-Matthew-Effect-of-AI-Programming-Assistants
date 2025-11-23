var totalCharacters = function(s, operations) {
    const n = s.length;
    let arr = Array(n).fill(1);

    for (const [start, end, val] of operations) {
        for (let i = start; i <= end; i++) {
            arr[i] = val;
        }
    }

    let count = 0;
    for (let i = 0; i < n; i++) {
        count += arr[i];
    }

    return count;
};