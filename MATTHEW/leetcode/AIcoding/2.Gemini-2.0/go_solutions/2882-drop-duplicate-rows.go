import (
	"fmt"
)

func dropDuplicateEmails(customers [][]interface{}) [][]interface{} {
	emailSet := make(map[string]bool)
	result := [][]interface{}{}

	for _, customer := range customers {
		email := customer[1].(string)
		if _, ok := emailSet[email]; !ok {
			emailSet[email] = true
			result = append(result, customer)
		}
	}

	return result
}