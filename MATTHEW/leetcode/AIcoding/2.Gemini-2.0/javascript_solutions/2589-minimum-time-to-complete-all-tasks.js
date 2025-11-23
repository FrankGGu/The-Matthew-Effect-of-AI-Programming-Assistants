var findMinimumTime = function(tasks) {
    tasks.sort((a, b) => a[1] - b[1]);
    const n = tasks.length;
    const timeline = new Array(2001).fill(false);
    let ans = 0;

    for (let i = 0; i < n; i++) {
        let start = tasks[i][0];
        let end = tasks[i][1];
        let duration = tasks[i][2];
        let count = 0;

        for (let j = start; j <= end; j++) {
            if (timeline[j]) {
                count++;
            }
        }

        if (count >= duration) {
            continue;
        }

        for (let j = end; j >= start && count < duration; j--) {
            if (!timeline[j]) {
                timeline[j] = true;
                count++;
                ans++;
            }
        }
    }

    return ans;
};