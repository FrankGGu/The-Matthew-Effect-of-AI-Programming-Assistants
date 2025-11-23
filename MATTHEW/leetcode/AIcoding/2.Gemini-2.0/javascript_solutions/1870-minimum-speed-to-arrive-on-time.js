var minSpeedOnTime = function(dist, hour) {
    let n = dist.length;
    if (hour <= n - 1) {
        return -1;
    }

    let left = 1;
    let right = 10000000;
    let ans = -1;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let time = 0;
        for (let i = 0; i < n - 1; i++) {
            time += Math.ceil(dist[i] / mid);
        }
        time += dist[n - 1] / mid;

        if (time <= hour) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
};