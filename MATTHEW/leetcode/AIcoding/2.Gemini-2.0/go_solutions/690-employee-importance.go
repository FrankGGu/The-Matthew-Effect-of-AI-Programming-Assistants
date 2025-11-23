func getImportance(employees []*Employee, id int) int {
    employeeMap := make(map[int]*Employee)
    for _, emp := range employees {
        employeeMap[emp.Id] = emp
    }

    var dfs func(int) int
    dfs = func(employeeId int) int {
        employee := employeeMap[employeeId]
        importance := employee.Importance
        for _, subId := range employee.Subordinates {
            importance += dfs(subId)
        }
        return importance
    }

    return dfs(id)
}