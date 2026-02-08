var longestObstacleCourseAtEachPosition = function(obstacles) {
    const n = obstacles.length;
    const dp = [];
    const result = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        const h = obstacles[i];
        let left = 0, right = dp.length;

        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (dp[mid] <= h) left = mid + 1;
            else right = mid;
        }

        if (left === dp.length) dp.push(h);
        else dp[left] = h;

        result[i] = left + 1;
    }

    return result;
};