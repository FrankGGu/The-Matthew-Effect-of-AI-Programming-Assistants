var transformArray = function(arr) {
    let result = arr.slice();
    let n = arr.length;

    for (let i = 1; i < n - 1; i++) {
        if (arr[i] % 2 === 0) {
            if (arr[i - 1] > arr[i] && arr[i + 1] > arr[i]) {
                result[i] += 1;
            } else if (arr[i - 1] < arr[i] && arr[i + 1] < arr[i]) {
                result[i] -= 1;
            }
        }
    }

    return result;
};