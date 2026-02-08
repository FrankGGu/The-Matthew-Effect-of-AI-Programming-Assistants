var maxValue = function(n, index, maxSum) {

    const getSum = (val, count) => {
        if (val < count) {
            return val * (val + 1) / 2 + (count - val);
        } else {
            return count * (2 * val - count + 1) / 2;
        }
    };

    const check = (x) => {
        let currentSum = x; 

        currentSum += getSum(x - 1, index);

        currentSum += getSum(x - 1, n - 1 - index);

        return currentSum <= maxSum;
    };

    let low = 1;
    let high = maxSum; 
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1; 
        } else {
            high = mid - 1; 
        }
    }

    return ans;
};