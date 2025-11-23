function numberOfEmployeesWhoMetTarget(employees, target) {
    return employees.filter(e => e >= target).length;
}