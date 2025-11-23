function findKthPositive(arr, k) {
    let missingCount = 0;
    let current = 1;
    let index = 0;

    while (missingCount < k) {
        if (index < arr.length && arr[index] === current) {
            index++;
        } else {
            missingCount++;
        }
        if (missingCount < k) current++;
    }

    return current;
}