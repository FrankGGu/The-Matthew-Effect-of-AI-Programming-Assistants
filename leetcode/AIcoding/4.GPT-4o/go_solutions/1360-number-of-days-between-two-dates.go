package main

import (
	"fmt"
	"time"
)

func daysBetweenDates(date1 string, date2 string) int {
	layout := "2006-01-02"
	d1, _ := time.Parse(layout, date1)
	d2, _ := time.Parse(layout, date2)
	return int(d2.Sub(d1).Hours() / 24)
}

func main() {
	fmt.Println(daysBetweenDates("2020-01-15", "2019-12-31"))
}