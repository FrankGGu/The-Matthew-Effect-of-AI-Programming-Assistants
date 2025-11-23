var maxTaskAssign = function(tasks, workers, pills, strength) {
    tasks.sort((a, b) => a - b);
    workers.sort((a, b) => a - b);

    let left = 0;
    let right = Math.min(tasks.length, workers.length);
    let answer = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (canAssign(mid, tasks, workers, pills, strength)) {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return answer;
};

function canAssign(k, tasks, workers, pills, strength) {
    const deque = [];
    let ptr = workers.length - 1;
    let usedPills = 0;

    for (let i = k - 1; i >= 0; i--) {
        const task = tasks[i];

        while (ptr >= workers.length - k && workers[ptr] + strength >= task) {
            deque.push(workers[ptr]);
            ptr--;
        }

        if (deque.length > 0 && deque[0] >= task) {
            deque.shift();
        } else if (deque.length > 0 && usedPills < pills) {
            deque.pop();
            usedPills++;
        } else {
            return false;
        }
    }

    return true;
}