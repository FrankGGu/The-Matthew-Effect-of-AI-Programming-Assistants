var maxRunTime = function(batteries, k) {
    let sum = 0;
    for (let battery of batteries) {
        sum += battery;
    }

    let left = 1;
    let right = Math.floor(sum / k);
    let ans = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let extra = 0;
        for (let battery of batteries) {
            extra += Math.min(battery, mid);
        }

        if (extra >= mid * k) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
};