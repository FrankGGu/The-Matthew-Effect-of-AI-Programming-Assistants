func getImportance(employees []*Employee, id int) int {
    employeeMap := make(map[int]*Employee)
    for _, emp := range employees {
        employeeMap[emp.Id] = emp
    }

    totalImportance := 0

    var dfs func(employeeId int)
    dfs = func(employeeId int) {
        emp := employeeMap[employeeId]
        if emp == nil {
            return
        }

        totalImportance += emp.Importance

        for _, subId := range emp.Subordinates {
            dfs(subId)
        }
    }

    dfs(id)

    return totalImportance
}