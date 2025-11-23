package main

func buyPensAndPencils(total int, cost1 int, cost2 int) int {
	ways := 0
	for pens := 0; pens*cost1 <= total; pens++ {
		remaining := total - pens*cost1
		if remaining >= 0 {
			ways += remaining / cost2 + 1
		}
	}
	return ways
}