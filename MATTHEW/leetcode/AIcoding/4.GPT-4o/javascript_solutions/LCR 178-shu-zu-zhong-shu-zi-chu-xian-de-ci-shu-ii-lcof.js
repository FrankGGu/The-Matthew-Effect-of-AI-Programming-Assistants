var canCompleteTasks = function(tasks, n) {
    let totalTime = 0;
    let totalDifficulty = 0;

    for (let i = 0; i < tasks.length; i++) {
        totalTime += tasks[i][0];
        totalDifficulty += tasks[i][1];
    }

    return totalTime <= n && totalDifficulty <= n;
};