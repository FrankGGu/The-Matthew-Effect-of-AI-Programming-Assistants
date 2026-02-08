var trainingPlan = function(tasks, limit) {
    tasks.sort((a, b) => a - b);
    let left = 0;
    let right = tasks.length - 1;
    let count = 0;

    while (left <= right) {
        if (tasks[left] + tasks[right] <= limit) {
            left++;
            right--;
        } else {
            right--;
        }
        count++;
    }

    return count;
};