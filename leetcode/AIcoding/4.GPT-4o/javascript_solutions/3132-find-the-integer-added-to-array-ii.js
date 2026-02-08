function findInteger(arr1, arr2) {
    const frequency = new Map();
    for (const num of arr1) {
        frequency.set(num, (frequency.get(num) || 0) + 1);
    }
    for (const num of arr2) {
        frequency.set(num, (frequency.get(num) || 0) - 1);
    }
    for (const [key, value] of frequency) {
        if (value === 1) {
            return key;
        }
    }
    return -1;
}