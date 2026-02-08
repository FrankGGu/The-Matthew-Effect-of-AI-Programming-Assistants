var longestObstacleCourseAtEachPosition = function(obstacles) {
    const n = obstacles.length;
    const dp = new Array(n).fill(1);
    const lis = [];

    for (let i = 0; i < n; i++) {
        const num = obstacles[i];
        let left = 0, right = lis.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (lis[mid] <= num) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        if (left === lis.length) {
            lis.push(num);
        } else {
            lis[left] = num;
        }
        dp[i] = left + 1;
    }
    return dp;
};