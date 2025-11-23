package main

import (
	"fmt"
	"math"
)

func powerfulIntegers(x int, y int, bound int) []int {
	powerfulInts := make(map[int]struct{})

	for a := 0; math.Pow(float64(x), float64(a)) < float64(bound); a++ {
		for b := 0; math.Pow(float64(y), float64(b)) < float64(bound); b++ {
			powerfulInt := int(math.Pow(float64(x), float64(a))) + int(math.Pow(float64(y), float64(b)))
			if powerfulInt <= bound {
				powerfulInts[powerfulInt] = struct{}{}
			} else {
				break
			}
			if x == 1 {
				break
			}
		}
		if y == 1 {
			break
		}
	}

	result := make([]int, 0, len(powerfulInts))
	for key := range powerfulInts {
		result = append(result, key)
	}

	return result
}

func main() {
	x := 2
	y := 3
	bound := 10
	result := powerfulIntegers(x, y, bound)
	fmt.Println(result)
}