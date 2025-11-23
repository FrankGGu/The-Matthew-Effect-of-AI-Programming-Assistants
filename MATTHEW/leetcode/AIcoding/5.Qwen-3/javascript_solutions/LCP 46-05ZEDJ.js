function minTasks(tasks, workers, pills) {
    tasks.sort((a, b) => a - b);
    workers.sort((a, b) => a - b);

    let left = 0;
    let right = tasks.length;

    function canComplete(days) {
        let taskIdx = tasks.length - 1;
        let workerIdx = workers.length - 1;
        let pillUsed = 0;
        let maxPills = pills;

        while (taskIdx >= 0 && workerIdx >= 0) {
            if (tasks[taskIdx] <= workers[workerIdx]) {
                taskIdx--;
                workerIdx--;
            } else {
                if (pillUsed < maxPills) {
                    taskIdx--;
                    pillUsed++;
                } else {
                    return false;
                }
            }
        }

        return taskIdx < 0;
    }

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (canComplete(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}