import "fmt"

func furthestDistanceFromOrigin(moves string) int {
	left := 0
	right := 0
	underscore := 0
	for _, move := range moves {
		if move == 'L' {
			left++
		} else if move == 'R' {
			right++
		} else {
			underscore++
		}
	}
	diff := abs(left - right)
	return diff + underscore
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}