function longestObstacleCourseAtEachPosition(obstacles) {
    const n = obstacles.length;
    const res = new Array(n).fill(0);
    const tails = [];

    for (let i = 0; i < n; i++) {
        let left = 0, right = tails.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (tails[mid] <= obstacles[i]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        if (left === tails.length) {
            tails.push(obstacles[i]);
        } else {
            tails[left] = obstacles[i];
        }

        res[i] = left + 1;
    }

    return res;
}