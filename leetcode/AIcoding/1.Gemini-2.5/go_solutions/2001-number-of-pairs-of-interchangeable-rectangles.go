func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

type Ratio struct {
	num int
	den int
}

func interchangeableRectangles(rectangles [][]int) int64 {
	// A map to store the frequency of each unique simplified ratio.
	ratioCounts := make(map[Ratio]int)

	for _, rect := range rectangles {
		w, h := rect[0], rect[1]

		// Calculate the greatest common divisor to simplify the ratio.
		commonDivisor := gcd(w, h)

		// Create the simplified ratio.
		simplifiedNum := w / commonDivisor
		simplifiedDen := h / commonDivisor

		// Use the simplified ratio as a key in the map and increment its count.
		ratio := Ratio{num: simplifiedNum, den: simplifiedDen}
		ratioCounts[ratio]++
	}

	var totalPairs int64
	// Iterate through the counts of each ratio.
	for _, count := range ratioCounts {
		// If a ratio appeared 'count' times, the number of pairs that can be formed
		// from these 'count' rectangles is count * (count - 1) / 2 (combinations "n choose 2").
		if count >= 2 {
			totalPairs += int64(count) * int64(count-1) / 2
		}
	}

	return totalPairs
}