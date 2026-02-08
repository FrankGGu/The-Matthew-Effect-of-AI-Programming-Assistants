function findAdjacentIncreasingSubarrays(arr) {
    const result = [];
    for (let i = 1; i < arr.length; i++) {
        if (arr[i] > arr[i - 1]) {
            if (result.length === 0 || result[result.length - 1][1] !== i - 1) {
                result.push([i - 1, i]);
            } else {
                result[result.length - 1][1] = i;
            }
        }
    }
    return result;
}