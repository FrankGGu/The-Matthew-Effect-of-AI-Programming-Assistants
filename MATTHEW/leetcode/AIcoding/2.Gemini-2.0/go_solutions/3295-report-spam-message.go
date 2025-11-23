import (
	"fmt"
)

type Report struct {
	SenderID    int
	ReceiverID  int
	ReportDate  string
}

type User struct {
	UserID int
	Name   string
}

func reportSpamMessages(reports []Report, users []User) []string {
	reported := make(map[int]int)
	userMap := make(map[int]string)
	for _, user := range users {
		userMap[user.UserID] = user.Name
	}

	for _, report := range reports {
		reported[report.SenderID]++
	}

	var spamUsers []string
	for userID, count := range reported {
		if count >= 5 {
			spamUsers = append(spamUsers, userMap[userID])
		}
	}

	return spamUsers
}