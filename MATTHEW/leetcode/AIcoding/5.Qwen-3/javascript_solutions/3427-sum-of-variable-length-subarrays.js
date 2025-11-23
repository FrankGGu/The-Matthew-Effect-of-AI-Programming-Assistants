function sumOfSubarrays(arr) {
    let n = arr.length;
    let total = 0;
    for (let i = 0; i < n; i++) {
        let current = 0;
        for (let j = i; j < n; j++) {
            current += arr[j];
            total += current;
        }
    }
    return total;
}