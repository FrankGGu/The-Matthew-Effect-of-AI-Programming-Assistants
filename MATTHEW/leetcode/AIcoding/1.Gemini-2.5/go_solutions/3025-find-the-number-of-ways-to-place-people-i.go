func numberOfWays(points [][]int) int {
	n := len(points)
	count := 0

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if i == j {
				continue
			}

			pxi, pyi := points[i][0], points[i][1]
			pxj, pyj := points[j][0], points[j][1]

			if pxi <= pxj && pyi >= pyj {
				foundIntermediate := false
				for k := 0; k < n; k++ {
					if k == i || k == j {
						continue
					}

					pxk, pyk := points[k][0], points[k][1]

					if pxi <= pxk && pyi >= pyk &&
						pxk <= pxj && pyk >= pyj {
						foundIntermediate = true
						break
					}
				}

				if !foundIntermediate {
					count++
				}
			}
		}
	}

	return count
}