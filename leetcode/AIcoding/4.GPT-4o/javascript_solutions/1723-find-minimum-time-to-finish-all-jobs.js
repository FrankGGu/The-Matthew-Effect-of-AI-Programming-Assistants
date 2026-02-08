var minimumTimeRequired = function(jobs, k) {
    let left = Math.max(...jobs);
    let right = jobs.reduce((a, b) => a + b, 0);

    const canFinish = (mid) => {
        const loads = Array(k).fill(0);
        const dfs = (index) => {
            if (index === jobs.length) return true;
            for (let i = 0; i < k; i++) {
                if (loads[i] + jobs[index] <= mid) {
                    loads[i] += jobs[index];
                    if (dfs(index + 1)) return true;
                    loads[i] -= jobs[index];
                }
                if (loads[i] === 0) break;
            }
            return false;
        };
        return dfs(0);
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canFinish(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};