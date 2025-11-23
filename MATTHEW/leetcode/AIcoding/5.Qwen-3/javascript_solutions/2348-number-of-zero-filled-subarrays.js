function zeroFilledSubarrays(nums) {
    let count = 0;
    let consecutiveZeros = 0;

    for (let num of nums) {
        if (num === 0) {
            consecutiveZeros++;
            count += consecutiveZeros;
        } else {
            consecutiveZeros = 0;
        }
    }

    return count;
}