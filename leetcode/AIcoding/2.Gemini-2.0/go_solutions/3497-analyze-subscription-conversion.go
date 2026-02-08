import "fmt"

type Sub struct {
	account_id int
	start_date string
	end_date   string
}

func analyzeSubscriptionConversion(subscriptions []Sub) []int {
	converted := 0
	total := 0

	for i := 0; i < len(subscriptions); i++ {
		if subscriptions[i].end_date != "2022-12-31" {
			total++
			next := findNextSubscription(subscriptions, subscriptions[i].account_id, subscriptions[i].end_date)
			if next != nil {
				converted++
			}
		}
	}

	if total == 0 {
		return []int{0, 0}
	}

	return []int{converted, total}
}

func findNextSubscription(subscriptions []Sub, accountID int, endDate string) *Sub {
	var nextSub *Sub
	minDate := "9999-12-31"

	for i := 0; i < len(subscriptions); i++ {
		if subscriptions[i].account_id == accountID && subscriptions[i].start_date > endDate {
			if subscriptions[i].start_date < minDate {
				minDate = subscriptions[i].start_date
				nextSub = &subscriptions[i]
			}
		}
	}

	return nextSub
}