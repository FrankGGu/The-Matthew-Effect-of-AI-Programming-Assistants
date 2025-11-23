var minimumTimeRequired = function(jobs, k) {
    let n = jobs.length;
    let res = Infinity;
    let workers = new Array(k).fill(0);

    jobs.sort((a, b) => b - a);

    function backtrack(index) {
        if (index === n) {
            res = Math.min(res, Math.max(...workers));
            return;
        }

        let seen = new Set();
        for (let i = 0; i < k; i++) {
            if (seen.has(workers[i])) continue;
            if (workers[i] + jobs[index] >= res) continue;
            seen.add(workers[i]);
            workers[i] += jobs[index];
            backtrack(index + 1);
            workers[i] -= jobs[index];
        }
    }

    backtrack(0);
    return res;
};