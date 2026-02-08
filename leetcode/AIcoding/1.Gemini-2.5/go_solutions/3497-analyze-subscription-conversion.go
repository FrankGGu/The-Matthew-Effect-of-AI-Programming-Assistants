package main

import (
	"sort"
	"time"
)

type SubscriptionEvent struct {
	UserID    int
	EventType string
	Timestamp time.Time
}

func AnalyzeSubscriptionConversion(events []SubscriptionEvent) float64 {
	sort.Slice(events, func(i, j int) bool {
		if events[i].UserID != events[j].UserID {
			return events[i].UserID < events[j].UserID
		}
		return events[i].Timestamp.Before(events[j].Timestamp)
	})

	signedUpUsers := make(map[int]bool)
	convertedUsers := make(map[int]bool)
	userHasSignedUp := make(map[int]bool)

	for _, event := range events {
		if event.EventType == "signup" {
			userHasSignedUp[event.UserID] = true
			signedUpUsers[event.UserID] = true
		} else if event.EventType == "subscribe" {
			if userHasSignedUp[event.UserID] {
				convertedUsers[event.UserID] = true
			}
		}
	}

	totalSignedUp := len(signedUpUsers)
	totalConverted := len(convertedUsers)

	if totalSignedUp == 0 {
		return 0.0
	}

	return float64(totalConverted) / float64(totalSignedUp)
}