function minSpeedOnTime(dist, hour) {
    if (dist.length === 0) return -1;
    let left = 1, right = 10000000;
    let result = -1;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let time = 0;

        for (let i = 0; i < dist.length - 1; i++) {
            time += Math.ceil(dist[i] / mid);
        }
        time += dist[dist.length - 1] / mid;

        if (time <= hour) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return result;
}