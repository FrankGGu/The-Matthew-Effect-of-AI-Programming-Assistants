function countAlternatingSubarrays(arr) {
    let count = 0;
    let n = arr.length;

    for (let i = 0; i < n; i++) {
        let length = 1;
        while (i + 1 < n && arr[i] + 1 === arr[i + 1]) {
            length++;
            i++;
        }
        count += (length * (length + 1)) / 2;
    }

    return count;
}