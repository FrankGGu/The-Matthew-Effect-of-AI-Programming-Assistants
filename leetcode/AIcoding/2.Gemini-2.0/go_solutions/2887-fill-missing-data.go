import "fmt"

type Employee struct {
	ID         int
	Name       string
	Department string
	Salary     int
}

func fillMissingData(employees []Employee) []Employee {
	for i := range employees {
		if employees[i].Name == "" {
			employees[i].Name = "Anonymous"
		}
	}
	return employees
}