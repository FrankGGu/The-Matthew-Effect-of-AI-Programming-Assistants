var findBestValue = function(arr, target) {
    let left = 0;
    let right = Math.max(...arr);
    let bestSum = Infinity;
    let bestValue = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const sum = calculateSum(arr, mid);

        if (sum < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }

        if (Math.abs(sum - target) < Math.abs(bestSum - target) || 
            (Math.abs(sum - target) === Math.abs(bestSum - target) && mid < bestValue)) {
            bestSum = sum;
            bestValue = mid;
        }
    }

    return bestValue;
};

function calculateSum(arr, value) {
    let sum = 0;
    for (const num of arr) {
        sum += Math.min(num, value);
    }
    return sum;
}