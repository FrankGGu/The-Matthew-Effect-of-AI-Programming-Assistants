var getImportance = function(id, employees) {
    const employeeMap = new Map();

    for (const employee of employees) {
        employeeMap.set(employee.id, employee);
    }

    const dfs = (employeeId) => {
        const employee = employeeMap.get(employeeId);
        let totalImportance = employee.importance;
        for (const sub of employee.subordinates) {
            totalImportance += dfs(sub);
        }
        return totalImportance;
    };

    return dfs(id);
};