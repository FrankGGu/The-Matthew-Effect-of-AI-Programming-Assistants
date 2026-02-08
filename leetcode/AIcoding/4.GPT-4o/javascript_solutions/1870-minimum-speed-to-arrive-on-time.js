function minSpeedOnTime(dist, hour) {
    let left = 1, right = 10**7, result = -1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        let totalTime = 0;

        for (let i = 0; i < dist.length; i++) {
            totalTime += (i === dist.length - 1) ? dist[i] / mid : Math.ceil(dist[i] / mid);
        }

        if (totalTime <= hour) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return result;
}