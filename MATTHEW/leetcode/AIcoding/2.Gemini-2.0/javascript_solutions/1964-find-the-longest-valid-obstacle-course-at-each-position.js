var longestObstacleCourseAtEachPosition = function(obstacles) {
    const n = obstacles.length;
    const tails = [];
    const result = new Array(n);

    for (let i = 0; i < n; i++) {
        const obstacle = obstacles[i];
        let left = 0;
        let right = tails.length;

        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (tails[mid] <= obstacle) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        if (left === tails.length) {
            tails.push(obstacle);
        } else {
            tails[left] = obstacle;
        }

        result[i] = left + 1;
    }

    return result;
};