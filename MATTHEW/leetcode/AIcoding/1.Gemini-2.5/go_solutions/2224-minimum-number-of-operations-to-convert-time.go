import (
	"strconv"
)

func convertTime(current string, correct string) int {
	currentHour, _ := strconv.Atoi(current[0:2])
	currentMinute, _ := strconv.Atoi(current[3:5])

	correctHour, _ := strconv.Atoi(correct[0:2])
	correctMinute, _ := strconv.Atoi(correct[3:5])

	currentTotalMinutes := currentHour*60 + currentMinute
	correctTotalMinutes := correctHour*60 + correctMinute

	diff := correctTotalMinutes - currentTotalMinutes

	operations := 0

	operations += diff / 60
	diff %= 60

	operations += diff / 15
	diff %= 15

	operations += diff / 5
	diff %= 5

	operations += diff

	return operations
}