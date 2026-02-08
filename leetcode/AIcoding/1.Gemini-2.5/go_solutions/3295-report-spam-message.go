package main

import (
	"math"
	"sort"
)

type Message struct {
	MessageID   int
	SenderID    int
	ReceiverID  int
	SentDate    string 
}

type Report struct {
	ReporterID  int
	MessageID   int
	ReportDate  string 
}

type SpamReport struct {
	SenderID       int
	SpamPercentage float64
}

func reportSpamMessage(messages []Message, reports []Report) []SpamReport {
	isSpamMessage := make(map[int]bool)
	for _, r := range reports {
		isSpamMessage[r.MessageID] = true
	}

	totalMessagesSentBySender := make(map[int]int)
	spamMessagesSentBySender := make(map[int]int)

	for _, msg := range messages {
		totalMessagesSentBySender[msg.SenderID]++
		if isSpamMessage[msg.MessageID] {
			spamMessagesSentBySender[msg.SenderID]++
		}
	}

	var results []SpamReport
	for senderID, totalCount := range totalMessagesSentBySender {
		spamCount := spamMessagesSentBySender[senderID] 

		var spamPercentage float64
		if totalCount == 0 {
			spamPercentage = 0.0
		} else {
			spamPercentage = (float64(spamCount) / float64(totalCount)) * 100.0
		}

		spamPercentage = math.Round(spamPercentage*100) / 100

		results = append(results, SpamReport{
			SenderID:       senderID,
			SpamPercentage: spamPercentage,
		})
	}

	sort.Slice(results, func(i, j int) bool {
		return results[i].SenderID < results[j].SenderID
	})

	return results
}