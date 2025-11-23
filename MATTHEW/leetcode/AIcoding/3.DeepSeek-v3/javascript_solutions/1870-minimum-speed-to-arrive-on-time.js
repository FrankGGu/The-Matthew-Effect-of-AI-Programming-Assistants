var minSpeedOnTime = function(dist, hour) {
    let left = 1;
    let right = 1e7;
    let minSpeed = -1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const totalTime = calculateTotalTime(dist, mid);

        if (totalTime <= hour) {
            minSpeed = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return minSpeed;
};

function calculateTotalTime(dist, speed) {
    let total = 0;
    for (let i = 0; i < dist.length; i++) {
        const time = dist[i] / speed;
        if (i === dist.length - 1) {
            total += time;
        } else {
            total += Math.ceil(time);
        }
    }
    return total;
}