var TaskManager = function() {
    this.tasks = [];
};

TaskManager.prototype.queue = function(task) {
    this.tasks.push(task);
};

TaskManager.prototype.cancel = function(taskId) {
    for (let i = 0; i < this.tasks.length; i++) {
        if (this.tasks[i].id === taskId) {
            this.tasks.splice(i, 1);
            return;
        }
    }
};

TaskManager.prototype.getTasks = function() {
    return this.tasks;
};