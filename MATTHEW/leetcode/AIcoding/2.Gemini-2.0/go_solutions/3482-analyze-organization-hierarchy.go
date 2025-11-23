import "sort"

type Employee struct {
	Id           int
	Name         string
	Department   string
	ManagerId    int
	Salary       int
}

func displayOrgChart(employees []Employee) []string {
	employeeMap := make(map[int]Employee)
	childrenMap := make(map[int][]int)

	for _, emp := range employees {
		employeeMap[emp.Id] = emp
		childrenMap[emp.ManagerId] = append(childrenMap[emp.ManagerId], emp.Id)
	}

	var rootId int
	for _, emp := range employees {
		isRoot := true
		for _, otherEmp := range employees {
			if emp.Id == otherEmp.ManagerId {
				isRoot = false
				break
			}
		}
		if isRoot {
			rootId = emp.Id
			break
		}
	}

	if _, ok := employeeMap[rootId]; !ok {
		for _, emp := range employees {
			if emp.ManagerId == 0 {
				rootId = emp.Id
				break
			}
		}
	}
	if rootId == 0 && len(employees) > 0 {
		rootId = employees[0].Id
	}

	var result []string
	var dfs func(employeeId int, indent string)
	dfs = func(employeeId int, indent string) {
		emp := employeeMap[employeeId]
		result = append(result, indent+emp.Name+", "+emp.Department+", "+string(rune(emp.Salary+'0')))

		children := childrenMap[employeeId]
		sort.Ints(children)
		for _, childId := range children {
			dfs(childId, indent+"  ")
		}
	}

	dfs(rootId, "")
	return result
}