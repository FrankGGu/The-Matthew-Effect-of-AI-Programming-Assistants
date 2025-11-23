var findBestValue = function(arr, target) {
    let left = 0, right = Math.max(...arr), bestValue = 0, closest = Infinity;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let sum = arr.reduce((acc, num) => acc + Math.min(num, mid), 0);

        if (Math.abs(target - sum) < closest) {
            closest = Math.abs(target - sum);
            bestValue = mid;
        } else if (Math.abs(target - sum) === closest) {
            bestValue = Math.min(bestValue, mid);
        }

        if (sum < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return bestValue;
};