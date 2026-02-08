package main

import (
	"strconv"
	"strings"
)

var daysInMonth = []int{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

func parseDate(dateStr string) int {
	parts := strings.Split(dateStr, "-")
	month, _ := strconv.Atoi(parts[0])
	day, _ := strconv.Atoi(parts[1])

	dayOfYear := 0
	for i := 1; i < month; i++ {
		dayOfYear += daysInMonth[i]
	}
	dayOfYear += day
	return dayOfYear
}

func countDaysTogether(aliceArrivalDate string, aliceLeaveDate string, bobArrivalDate string, bobLeaveDate string) int {
	aliceArrival := parseDate(aliceArrivalDate)
	aliceLeave := parseDate(aliceLeaveDate)
	bobArrival := parseDate(bobArrivalDate)
	bobLeave := parseDate(bobLeaveDate)

	latestArrival := aliceArrival
	if bobArrival > latestArrival {
		latestArrival = bobArrival
	}

	earliestLeave := aliceLeave
	if bobLeave < earliestLeave {
		earliestLeave = bobLeave
	}

	if latestArrival > earliestLeave {
		return 0
	}

	return earliestLeave - latestArrival + 1
}