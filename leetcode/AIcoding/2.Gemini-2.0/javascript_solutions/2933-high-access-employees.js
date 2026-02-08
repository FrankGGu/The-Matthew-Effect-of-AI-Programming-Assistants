var findHighAccessEmployees = function(access_times) {
    const employeeAccess = {};
    for (const [employee, time] of access_times) {
        if (!employeeAccess[employee]) {
            employeeAccess[employee] = [];
        }
        employeeAccess[employee].push(parseInt(time));
    }

    const highAccess = [];
    for (const employee in employeeAccess) {
        employeeAccess[employee].sort((a, b) => a - b);
        const times = employeeAccess[employee];
        for (let i = 0; i < times.length - 2; i++) {
            if (times[i + 2] - times[i] < 100) {
                highAccess.push(employee);
                break;
            }
        }
    }

    return highAccess;
};