import (
	"strconv"
)

func countSeniors(details []string) int {
	seniorCitizens := 0
	for _, detail := range details {
		ageStr := detail[11:13]
		age, _ := strconv.Atoi(ageStr)
		if age > 60 {
			seniorCitizens++
		}
	}
	return seniorCitizens
}