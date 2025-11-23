func maxCandies(boxes []int, keys []int, locked []int, initialBoxes []int) int {
	n := len(boxes)
	q := []int{}
	has := make([]bool, n)
	opened := make([]bool, n)
	for _, box := range initialBoxes {
		q = append(q, box)
		has[box] = true
	}
	ans := 0
	for len(q) > 0 {
		box := q[0]
		q = q[1:]
		if locked[box] == 1 && !hasKey(keys, box) {
			q = append(q, box)
			continue
		}
		if opened[box] {
			continue
		}
		opened[box] = true
		ans += boxes[box]
		for i := 0; i < n; i++ {
			if keys[box]&(1<<i) > 0 {
				has[i] = true
				if !opened[i] && locked[i] == 0 {
					q = append(q, i)
				} else if !opened[i] && locked[i] == 1 && hasKey(keys, i) {

                    q = append(q, i)
				}
			}
		}
		for i := 0; i < n; i++ {
			if !has[i] && keys[box]&(1<<i) > 0 {
				has[i] = true
			}
		}
	}
	return ans
}

func hasKey(keys []int, box int) bool {
	for i := 0; i < len(keys); i++ {
		if keys[i]&(1<<box) > 0 {
			return true
		}
	}
	return false
}