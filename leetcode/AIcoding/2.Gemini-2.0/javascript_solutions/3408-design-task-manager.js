class TaskManager {
  constructor() {
    this.tasks = {};
    this.dependencies = {};
  }

  addTask(taskId) {
    if (!this.tasks[taskId]) {
      this.tasks[taskId] = { completed: false, dependencies: [] };
    }
  }

  addDependency(taskId, prerequisiteTaskId) {
    if (!this.tasks[taskId]) {
      this.addTask(taskId);
    }
    if (!this.tasks[prerequisiteTaskId]) {
      this.addTask(prerequisiteTaskId);
    }
    this.tasks[taskId].dependencies.push(prerequisiteTaskId);
    if (!this.dependencies[prerequisiteTaskId]) {
        this.dependencies[prerequisiteTaskId] = [];
    }
    this.dependencies[prerequisiteTaskId].push(taskId);
  }

  completeTask(taskId) {
    if (!this.tasks[taskId]) {
      return false;
    }

    if (this.tasks[taskId].completed) {
      return true;
    }

    for (const dependency of this.tasks[taskId].dependencies) {
      if (!this.tasks[dependency].completed) {
        return false;
      }
    }

    this.tasks[taskId].completed = true;

      if (this.dependencies[taskId]) {
        for (const dependentTask of this.dependencies[taskId]) {
            this.completeTask(dependentTask);
        }
      }

    return true;
  }
}