class TaskManager {
    constructor() {
        this.tasks = {};
        this.id = 1;
    }

    addTask(duration) {
        const id = this.id++;
        this.tasks[id] = {
            duration: duration,
            startTime: Date.now(),
            completed: false
        };
        return id;
    }

    cancelTask(id) {
        if (!this.tasks[id] || this.tasks[id].completed) {
            return false;
        }
        const currentTime = Date.now();
        const elapsed = currentTime - this.tasks[id].startTime;
        if (elapsed >= this.tasks[id].duration) {
            return false;
        }
        delete this.tasks[id];
        return true;
    }

    getTaskTime(id) {
        if (!this.tasks[id]) {
            return -1;
        }
        const currentTime = Date.now();
        const elapsed = currentTime - this.tasks[id].startTime;
        if (elapsed >= this.tasks[id].duration) {
            this.tasks[id].completed = true;
            return this.tasks[id].duration;
        } else {
            return elapsed;
        }
    }
}