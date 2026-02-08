import (
	"container/list"
	"math"
)

func isPrintable(targetGrid [][]int) bool {
	m := len(targetGrid)
	n := len(targetGrid[0])

	// Max color value is 60. Use arrays of size 61 for colors.
	const maxColor = 60

	minR := make([]int, maxColor+1)
	maxR := make([]int, maxColor+1)
	minC := make([]int, maxColor+1)
	maxC := make([]int, maxColor+1)
	colorsPresent := make([]bool, maxColor+1)
	totalUniqueColors := 0

	// Initialize min/max coordinates
	for i := 1; i <= maxColor; i++ {
		minR[i] = m
		minC[i] = n
		maxR[i] = -1
		maxC[i] = -1
	}

	// 1. Find bounding boxes for each color and mark colors present
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			color := targetGrid[r][c]
			if !colorsPresent[color] {
				colorsPresent[color] = true
				totalUniqueColors++
			}
			minR[color] = int(math.Min(float64(minR[color]), float64(r)))
			maxR[color] = int(math.Max(float64(maxR[color]), float64(r)))
			minC[color] = int(math.Min(float64(minC[color]), float64(c)))
			maxC[color] = int(math.Max(float64(maxC[color]), float64(c)))
		}
	}

	// cellsToColors[r][c] stores a list of colors whose bounding box contains (r,c)
	cellsToColors := make([][][]int, m)
	for r := range cellsToColors {
		cellsToColors[r] = make([][]int, n)
	}

	// blockers[color] counts how many cells (r,c) within B(color) have targetGrid[r][c] != color
	blockers := make([]int, maxColor+1)

	// 2. Build cellsToColors and initialize blockers
	for c1 := 1; c1 <= maxColor; c1++ {
		if !colorsPresent[c1] {
			continue
		}
		for r := minR[c1]; r <= maxR[c1]; r++ {
			for c := minC[c1]; c <= maxC[c1]; c++ {
				cellsToColors[r][c] = append(cellsToColors[r][c], c1)
				if targetGrid[r][c] != c1 {
					blockers[c1]++
				}
			}
		}
	}

	// 3. Initialize queue for colors that can be "erased"
	q := list.New()
	erased := make([]bool, maxColor+1)
	processedColorsCount := 0

	for c := 1; c <= maxColor; c++ {
		if colorsPresent[c] && blockers[c] == 0 {
			q.PushBack(c)
			erased[c] = true // Mark as erased to prevent re-adding to queue immediately
		}
	}

	// 4. Perform "reverse" topological sort (erasing process)
	for q.Len() > 0 {
		e := q.Front()
		q.Remove(e)
		cErase := e.Value.(int)

		processedColorsCount++

		// When cErase is "erased", cells within its bounding box effectively become 0.
		// This might unblock other colors.
		for r := minR[cErase]; r <= maxR[cErase]; r++ {
			for c := minC[cErase]; c <= maxC[cErase]; c++ {
				// For each color cOther whose bounding box contains (r,c)
				for _, cOther := range cellsToColors[r][c] {
					if cOther != cErase && !erased[cOther] {
						// If (r,c) was originally cErase, and cErase != cOther,
						// then (r,c) was a blocker for cOther.
						// Now that cErase is "removed", (r,c) is no longer a blocker.
						// So, decrement cOther's blocker count.
						// Note: This logic implicitly assumes that if targetGrid[r][c] was cErase,
						// it was indeed a blocker for cOther if cOther != cErase.
						// This is true because targetGrid[r][c] != cOther.
						blockers[cOther]--
						if blockers[cOther] == 0 {
							q.PushBack(cOther)
							erased[cOther] = true // Mark as erased to prevent re-adding
						}
					}
				}
			}
		}
	}

	return processedColorsCount == totalUniqueColors
}