func minMovesToCaptureTheQueen(rookA int, rookB int, bishopA int, bishopB int, queenA int, queenB int) int {
	ans := 2
	if rookA == queenA {
		blocked := false
		start, end := min(rookB, queenB)+1, max(rookB, queenB)
		for i := bishopA; i <= 8; i++ {
			for j := 1; j <= 8; j++ {
				if i == bishopA && j == bishopB && i == rookA && j >= start && j < end {
					blocked = true
					break
				}
			}
			if blocked {
				break
			}

		}
		if !blocked {
			ans = 1
		}

	}
	if rookB == queenB {
		blocked := false
		start, end := min(rookA, queenA)+1, max(rookA, queenA)
		for i := bishopA; i <= 8; i++ {
			for j := 1; j <= 8; j++ {
				if i == bishopA && j == bishopB && j == rookB && i >= start && i < end {
					blocked = true
					break
				}
			}
			if blocked {
				break
			}

		}
		if !blocked {
			ans = 1
		}

	}
	if bishopA+bishopB == queenA+queenB {
		blocked := false
		startA, startB := bishopA, bishopB
		for startA != queenA {
			if bishopA < queenA {
				startA++
				startB--
			} else {
				startA--
				startB++
			}
			if startA == rookA && startB == rookB {
				blocked = true
				break
			}
		}
		if !blocked {
			if ans > 1 {
				ans = 1
			}

		}
	}
	if bishopA-bishopB == queenA-queenB {
		blocked := false
		startA, startB := bishopA, bishopB
		for startA != queenA {
			if bishopA < queenA {
				startA++
				startB++
			} else {
				startA--
				startB--
			}
			if startA == rookA && startB == rookB {
				blocked = true
				break
			}
		}
		if !blocked {
			if ans > 1 {
				ans = 1
			}

		}
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}