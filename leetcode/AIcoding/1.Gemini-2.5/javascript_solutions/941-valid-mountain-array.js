var validMountainArray = function(arr) {
    const n = arr.length;
    if (n < 3) {
        return false;
    }

    let i = 0;

    // Walk up the mountain
    while (i + 1 < n && arr[i] < arr[i + 1]) {
        i++;
    }

    // Peak cannot be the first or the last element
    if (i === 0 || i === n - 1) {
        return false;
    }

    // Walk down the mountain
    while (i + 1 < n && arr[i] > arr[i + 1]) {
        i++;
    }

    // If we reached the end, it's a valid mountain
    return i === n - 1;
};