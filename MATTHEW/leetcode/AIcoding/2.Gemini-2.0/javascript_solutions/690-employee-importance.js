var GetImportance = function(employees, id) {
    const employeeMap = new Map();
    for (const employee of employees) {
        employeeMap.set(employee.id, employee);
    }

    let totalImportance = 0;

    function dfs(employeeId) {
        const employee = employeeMap.get(employeeId);
        if (!employee) return;

        totalImportance += employee.importance;

        for (const subordinateId of employee.subordinates) {
            dfs(subordinateId);
        }
    }

    dfs(id);

    return totalImportance;
};