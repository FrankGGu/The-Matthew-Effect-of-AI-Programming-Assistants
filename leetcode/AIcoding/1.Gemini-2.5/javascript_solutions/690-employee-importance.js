var GetImportance = function(employees, id) {
    const employeeMap = new Map();
    for (const emp of employees) {
        employeeMap.set(emp.id, emp);
    }

    let totalImportance = 0;

    function dfs(employeeId) {
        const employee = employeeMap.get(employeeId);
        if (!employee) {
            return;
        }

        totalImportance += employee.importance;

        for (const subId of employee.subordinates) {
            dfs(subId);
        }
    }

    dfs(id);

    return totalImportance;
};