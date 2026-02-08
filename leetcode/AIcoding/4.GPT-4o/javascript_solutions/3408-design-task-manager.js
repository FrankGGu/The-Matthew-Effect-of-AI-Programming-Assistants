class TaskManager {
    constructor() {
        this.tasks = new Map();
        this.currentTime = 0;
    }

    addTask(task, duration) {
        this.tasks.set(task, {
            duration: duration,
            remainingTime: duration,
            finished: false
        });
    }

    getNextTask() {
        for (let [task, info] of this.tasks) {
            if (!info.finished) {
                return task;
            }
        }
        return null;
    }

    runTask(task, time) {
        if (!this.tasks.has(task)) return;

        const info = this.tasks.get(task);
        const runTime = Math.min(info.remainingTime, time);
        info.remainingTime -= runTime;
        this.currentTime += runTime;

        if (info.remainingTime === 0) {
            info.finished = true;
        }
    }

    getCurrentTime() {
        return this.currentTime;
    }
}