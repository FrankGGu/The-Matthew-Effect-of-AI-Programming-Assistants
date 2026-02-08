function maximumDifference(nums) {
    let evenCount = 0, oddCount = 0;
    for (let num of nums) {
        if (num % 2 === 0) {
            evenCount++;
        } else {
            oddCount++;
        }
    }
    return Math.abs(evenCount - oddCount);
}