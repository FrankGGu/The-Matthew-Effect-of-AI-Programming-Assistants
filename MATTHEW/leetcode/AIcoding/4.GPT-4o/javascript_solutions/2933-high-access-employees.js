function highAccessEmployees(employees, low) {
    const result = [];
    for (let i = 0; i < employees.length; i++) {
        if (employees[i].accessLevel > low) {
            result.push(employees[i].name);
        }
    }
    return result;
}