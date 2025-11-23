package main

func minimumPerimeter(neededApples int64) int64 {
	var s int64 = 0
	for {
		s++
		currentApples := 2 * (2*s + 1) * s * (s + 1)
		if currentApples >= neededApples {
			break
		}
	}
	return 8 * s
}