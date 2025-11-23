var minimumEffort = function(tasks) {
    tasks.sort((a, b) => (b[1] - b[0]) - (a[1] - a[0]));
    let energy = 0;
    let currentEnergy = 0;
    for (let i = 0; i < tasks.length; i++) {
        if (currentEnergy < tasks[i][1]) {
            energy += tasks[i][1] - currentEnergy;
            currentEnergy = tasks[i][1];
        }
        currentEnergy -= tasks[i][0];
    }
    return energy;
};