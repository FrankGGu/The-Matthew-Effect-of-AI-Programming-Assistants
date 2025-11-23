var sumIndicesWithKSetBits = function(arr, k) {
    const countSetBits = (num) => {
        let count = 0;
        while (num) {
            count += num & 1;
            num >>= 1;
        }
        return count;
    };

    let sum = 0;
    for (let i = 0; i < arr.length; i++) {
        if (countSetBits(i) === k) {
            sum += arr[i];
        }
    }
    return sum;
};