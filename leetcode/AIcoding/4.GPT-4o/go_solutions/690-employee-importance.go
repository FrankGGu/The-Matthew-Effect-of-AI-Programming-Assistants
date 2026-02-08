type Employee struct {
    Id             int
    Importance     int
    Subordinates   []int
}

func getImportance(employees []Employee, id int) int {
    empMap := make(map[int]Employee)
    for _, emp := range employees {
        empMap[emp.Id] = emp
    }

    var dfs func(int) int
    dfs = func(id int) int {
        emp := empMap[id]
        total := emp.Importance
        for _, subId := range emp.Subordinates {
            total += dfs(subId)
        }
        return total
    }

    return dfs(id)
}