function canComplete(tasks, capacity) {
    let total = 0;
    for (let i = 0; i < tasks.length; i++) {
        total += tasks[i];
    }
    return total <= capacity;
}

function trainingPlanIV(tasks, capacity) {
    let left = Math.max(...tasks);
    let right = tasks.reduce((a, b) => a + b, 0);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canComplete(tasks, mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}