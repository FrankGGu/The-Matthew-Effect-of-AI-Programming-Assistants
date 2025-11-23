var minimumTimeRequired = function(jobs, k) {
    let n = jobs.length;
    let left = Math.max(...jobs);
    let right = jobs.reduce((a, b) => a + b, 0);
    let ans = right;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let workers = new Array(k).fill(0);

        function canFinish(index) {
            if (index === n) {
                return true;
            }

            for (let i = 0; i < k; i++) {
                if (workers[i] + jobs[index] <= mid) {
                    workers[i] += jobs[index];
                    if (canFinish(index + 1)) {
                        return true;
                    }
                    workers[i] -= jobs[index];
                }
                if (workers[i] === 0) break;
            }
            return false;
        }

        if (canFinish(0)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
};