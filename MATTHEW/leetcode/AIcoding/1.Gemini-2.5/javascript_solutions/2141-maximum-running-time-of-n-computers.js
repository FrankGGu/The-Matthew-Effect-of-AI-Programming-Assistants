var maxRunTime = function(n, batteries) {
    let low = 0;
    let high = 0;
    for (let i = 0; i < batteries.length; i++) {
        high += batteries[i];
    }
    high = Math.floor(high / n);

    let ans = 0;

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);

        let currentAvailablePower = 0;
        for (let i = 0; i < batteries.length; i++) {
            currentAvailablePower += Math.min(batteries[i], mid);
        }

        if (currentAvailablePower >= n * mid) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};