var countGoodSubarrays = function(arr) {
    let count = 0;
    for (let i = 0; i <= arr.length - 3; i++) {
        const a = arr[i];
        const b = arr[i + 1];
        const c = arr[i + 2];
        if ((a === b && a !== c) || (a === c && a !== b) || (b === c && b !== a)) {
            count++;
        }
    }
    return count;
};