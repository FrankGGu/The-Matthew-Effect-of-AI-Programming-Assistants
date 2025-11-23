import (
	"container/list"
)

func minReverseOperations(n int, p int, banned []int, k int) []int {
	ans := make([]int, n)
	for i := range ans {
		ans[i] = -1
	}
	ans[p] = 0

	bannedSet := make(map[int]bool)
	for _, b := range banned {
		bannedSet[b] = true
	}

	q := list.New()
	q.PushBack(p)

	evenSet := make(map[int]bool)
	oddSet := make(map[int]bool)
	for i := 0; i < n; i++ {
		if bannedSet[i] || i == p {
			continue
		}
		if i%2 == 0 {
			evenSet[i] = true
		} else {
			oddSet[i] = true
		}
	}

	dist := 1
	for q.Len() > 0 {
		size := q.Len()
		for i := 0; i < size; i++ {
			curr := q.Front().Value.(int)
			q.Remove(q.Front())

			low := max(0, curr-(k-1))
			high := min(n-1, curr+(k-1))

			start := (low + k - 1 - curr) % 2
			for j := low + start; j <= high; j += 2 {
				if abs(j-curr) > k-1 {
					continue
				}
				if ans[j] == -1 {
					if curr-(k-1) <= j && j <= curr+(k-1) {
						if (curr+j-k+1 >= 0) && (curr+j+k-1 <= 2*n-2) {
							if (curr+j-k+1) % 2 == 0 {
								if _, ok := evenSet[j]; ok {
									ans[j] = dist
									q.PushBack(j)
									delete(evenSet, j)
								}
							} else {
								if _, ok := oddSet[j]; ok {
									ans[j] = dist
									q.PushBack(j)
									delete(oddSet, j)
								}
							}
						}

					}
				}
			}
		}
		dist++
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}