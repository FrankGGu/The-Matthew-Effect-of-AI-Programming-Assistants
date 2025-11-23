package main

type Point struct {
	X int
	Y int
}

func validSquare(p1 Point, p2 Point, p3 Point, p4 Point) bool {
	getDist := func(a, b Point) int {
		return (a.X-b.X)*(a.X-b.X) + (a.Y-b.Y)*(a.Y-b.Y)
	}

	dists := []int{
		getDist(p1, p2),
		getDist(p1, p3),
		getDist(p1, p4),
		getDist(p2, p3),
		getDist(p2, p4),
		getDist(p3, p4),
	}

	for i := 0; i < len(dists); i++ {
		for j := i + 1; j < len(dists); j++ {
			if dists[i] == dists[j] {
				dists[i] = -1
				dists[j] = -1
				break
			}
		}
	}

	count := 0
	for _, d := range dists {
		if d != -1 {
			count++
		}
	}

	return count == 2
}