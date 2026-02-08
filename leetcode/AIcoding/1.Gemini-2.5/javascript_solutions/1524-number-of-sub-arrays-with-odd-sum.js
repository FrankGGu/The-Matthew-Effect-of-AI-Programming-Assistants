var numOfSubarrays = function(arr) {
    let countEven = 1;
    let countOdd = 0;
    let currentSum = 0;
    let totalOddSubarrays = 0;
    const MOD = 10**9 + 7;

    for (let i = 0; i < arr.length; i++) {
        currentSum += arr[i];
        if (currentSum % 2 === 0) {
            totalOddSubarrays = (totalOddSubarrays + countOdd) % MOD;
            countEven++;
        } else {
            totalOddSubarrays = (totalOddSubarrays + countEven) % MOD;
            countOdd++;
        }
    }

    return totalOddSubarrays;
};