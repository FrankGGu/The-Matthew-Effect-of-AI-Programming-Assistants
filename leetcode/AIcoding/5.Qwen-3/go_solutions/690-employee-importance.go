package main

type Employee struct {
	ID     int
	Importance int
	Subordinates []int
}

func getImportance(employees []*Employee, id int) int {
	employeeMap := make(map[int]*Employee)
	for _, e := range employees {
		employeeMap[e.ID] = e
	}
	var dfs func(id int) int
	dfs = func(id int) int {
		e := employeeMap[id]
		total := e.Importance
		for _, sub := range e.Subordinates {
			total += dfs(sub)
		}
		return total
	}
	return dfs(id)
}