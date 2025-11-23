function divisibleAndNonDivisibleSumsDifference(arr, n) {
    let divisibleSum = 0;
    let nonDivisibleSum = 0;

    for (let num of arr) {
        if (num % n === 0) {
            divisibleSum += num;
        } else {
            nonDivisibleSum += num;
        }
    }

    return Math.abs(divisibleSum - nonDivisibleSum);
}