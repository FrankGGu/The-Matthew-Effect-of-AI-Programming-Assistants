var longestObstacleCourseAtEachPosition = function(obstacles) {
    const n = obstacles.length;
    const answer = new Array(n);
    const tails = []; // tails[k] stores the smallest ending element of a non-decreasing subsequence of length k+1

    function upper_bound(arr, target) {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] > target) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return low;
    }

    for (let i = 0; i < n; i++) {
        const obstacle = obstacles[i];

        const idx = upper_bound(tails, obstacle);

        answer[i] = idx + 1;

        if (idx === tails.length) {
            tails.push(obstacle);
        } else {
            tails[idx] = obstacle;
        }
    }

    return answer;
};