function sumOddLengthSubarrays(arr) {
    let total = 0;
    const n = arr.length;
    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = i; j < n; j++) {
            count++;
            if (count % 2 === 1) {
                for (let k = i; k <= j; k++) {
                    total += arr[k];
                }
            }
        }
    }
    return total;
}