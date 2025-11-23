var minSessions = function(tasks, sessionTime) {
    const n = tasks.length;
    let ans = n;

    for (let mask = 0; mask < (1 << n); mask++) {
        let sessions = 0;
        let currentSessionTime = 0;
        let currentTasks = [];

        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) !== 0) {
                currentTasks.push(tasks[i]);
            }
        }

        if (currentTasks.length === 0) continue;

        sessions = 1;
        currentSessionTime = 0;

        for (let i = 0; i < currentTasks.length; i++) {
            if (currentSessionTime + currentTasks[i] <= sessionTime) {
                currentSessionTime += currentTasks[i];
            } else {
                sessions++;
                currentSessionTime = currentTasks[i];
            }
        }

        if (sessions <= n) {
            let remainingTasks = [];
            for(let i = 0; i < n; i++){
                if((mask & (1 << i)) === 0){
                    remainingTasks.push(tasks[i]);
                }
            }

            if(remainingTasks.length === 0){
                ans = Math.min(ans, sessions);
            } else {
                let remainingSessions = minSessions(remainingTasks, sessionTime);
                ans = Math.min(ans, sessions + remainingSessions);
            }
        }

    }

    return ans;
};