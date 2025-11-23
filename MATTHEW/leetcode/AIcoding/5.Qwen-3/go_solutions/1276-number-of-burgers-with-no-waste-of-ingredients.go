package main

func numOfBurgers(totalX int, totalY int) []int {
	if totalX%2 != 0 || totalY%2 != 0 {
		return []int{}
	}
	x := totalX / 2
	y := totalY / 2
	if x < 0 || y < 0 {
		return []int{}
	}
	if x+y == 0 {
		return []int{}
	}
	if x < y {
		return []int{}
	}
	return []int{y, x - y}
}