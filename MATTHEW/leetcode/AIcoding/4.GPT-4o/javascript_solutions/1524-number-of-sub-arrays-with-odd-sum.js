var numOfSubarrays = function(arr) {
    let count = 0, oddCount = 0, evenCount = 1, currentSum = 0;

    for (let num of arr) {
        currentSum += num;

        if (currentSum % 2 === 0) {
            count += oddCount;
            evenCount++;
        } else {
            count += evenCount;
            oddCount++;
        }
    }

    return count;
};