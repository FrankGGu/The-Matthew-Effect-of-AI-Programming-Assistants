package main

func numberOfBoomerangs(points [][]int) int {
    n := len(points)
    if n < 3 {
        return 0
    }

    totalBoomerangs := 0

    for i := 0; i < n; i++ {
        distanceCounts := make(map[int]int)
        for j := 0; j < n; j++ {
            if i == j {
                continue
            }

            dx := points[i][0] - points[j][0]
            dy := points[i][1] - points[j][1]

            distSq := dx*dx + dy*dy
            distanceCounts[distSq]++
        }

        for _, count := range distanceCounts {
            if count >= 2 {
                totalBoomerangs += count * (count - 1)
            }
        }
    }

    return totalBoomerangs
}