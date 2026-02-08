type Employee struct {
    Id       int
    Importance int
    Subordinates []int
}

func getImportance(employees []Employee, id int) int {
    employeeMap := make(map[int]Employee)
    for _, emp := range employees {
        employeeMap[emp.Id] = emp
    }
    return dfs(employeeMap, id)
}

func dfs(employeeMap map[int]Employee, id int) int {
    emp := employeeMap[id]
    totalImportance := emp.Importance
    for _, subId := range emp.Subordinates {
        totalImportance += dfs(employeeMap, subId)
    }
    return totalImportance
}