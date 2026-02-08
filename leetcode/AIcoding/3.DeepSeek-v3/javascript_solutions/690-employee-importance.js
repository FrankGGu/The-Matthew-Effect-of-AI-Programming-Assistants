var GetImportance = function(employees, id) {
    const map = new Map();
    for (const employee of employees) {
        map.set(employee.id, employee);
    }

    let totalImportance = 0;
    const queue = [id];

    while (queue.length > 0) {
        const currentId = queue.shift();
        const employee = map.get(currentId);
        totalImportance += employee.importance;

        for (const subordinateId of employee.subordinates) {
            queue.push(subordinateId);
        }
    }

    return totalImportance;
};