package main

import (
	"fmt"
	"math/bits"
)

func readBinaryWatch(turnedOn int) []string {
	result := []string{}

	for h := 0; h < 12; h++ {
		for m := 0; m < 60; m++ {
			if bits.OnesCount(uint(h))+bits.OnesCount(uint(m)) == uint(turnedOn) {
				result = append(result, fmt.Sprintf("%d:%02d", h, m))
			}
		}
	}

	return result
}