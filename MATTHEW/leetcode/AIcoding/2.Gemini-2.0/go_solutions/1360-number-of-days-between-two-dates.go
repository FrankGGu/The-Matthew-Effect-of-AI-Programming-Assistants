import "time"

func daysBetweenDates(date1 string, date2 string) int {
	t1, _ := time.Parse("2006-01-02", date1)
	t2, _ := time.Parse("2006-01-02", date2)

	diff := t1.Sub(t2).Hours() / 24

	if diff < 0 {
		return int(-diff)
	}
	return int(diff)
}