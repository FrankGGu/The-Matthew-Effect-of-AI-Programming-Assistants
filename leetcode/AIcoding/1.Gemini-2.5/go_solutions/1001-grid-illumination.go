package main

type pair struct {
	r, c int
}

func gridIllumination(n int, lamps [][]int, queries [][]int) []int {
	rows := make(map[int]int)
	cols := make(map[int]int)
	diag1 := make(map[int]int) // r - c
	diag2 := make(map[int]int) // r + c

	activeLamps := make(map[pair]bool)

	for _, lamp := range lamps {
		r, c := lamp[0], lamp[1]
		p := pair{r, c}
		if !activeLamps[p] {
			activeLamps[p] = true
			rows[r]++
			cols[c]++
			diag1[r-c]++
			diag2[r+c]++
		}
	}

	results := make([]int, len(queries))

	dr := []int{-1, -1, -1, 0, 0, 0, 1, 1, 1}
	dc := []int{-1, 0, 1, -1, 0, 1, -1, 0, 1}

	for i, query := range queries {
		qr, qc := query[0], query[1]

		if rows[qr] > 0 || cols[qc] > 0 || diag1[qr-qc] > 0 || diag2[qr+qc] > 0 {
			results[i] = 1
		} else {
			results[i] = 0
		}

		for j := 0; j < 9; j++ {
			nr, nc := qr+dr[j], qc+dc[j]

			if nr >= 0 && nr < n && nc >= 0 && nc < n {
				p := pair{nr, nc}
				if activeLamps[p] {
					delete(activeLamps, p)
					rows[nr]--
					cols[nc]--
					diag1[nr-nc]--
					diag2[nr+nc]--
				}
			}
		}
	}

	return results
}