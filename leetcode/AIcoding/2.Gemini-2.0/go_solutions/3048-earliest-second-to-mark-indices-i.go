import "sort"

func earliestSecondToMarkIndices(nums []int, changeIndices []int) int {
	n := len(nums)
	m := len(changeIndices)

	check := func(t int) bool {
		last := make([]int, n+1)
		for i := 0; i < t; i++ {
			last[changeIndices[i]] = i + 1
		}

		for i := 1; i <= n; i++ {
			if last[i] == 0 {
				return false
			}
		}

		marked := make([]bool, n)
		time := 0
		for i := 1; i <= t; i++ {
			idx := changeIndices[i-1]
			if last[idx] == i && !marked[idx-1] {
				if nums[idx-1] <= time {
					marked[idx-1] = true
				} else {
					time++
				}
			} else {
				time++
			}
		}

		for i := 0; i < n; i++ {
			if !marked[i] {
				return false
			}
		}
		return true
	}

	left, right := 1, m
	ans := -1

	for left <= right {
		mid := left + (right-left)/2
		if check(mid) {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return ans
}

func earliestSecondToMarkIndicesII(nums []int, changeIndices []int) int {
    n := len(nums)
    m := len(changeIndices)

    check := func(t int) bool {
        last := make([]int, n)
        for i := 0; i < t; i++ {
            last[changeIndices[i]-1] = i + 1
        }

        for i := 0; i < n; i++ {
            if last[i] == 0 {
                return false
            }
        }

        available := make([]int, 0)
        for i := 0; i < t; i++ {
            idx := changeIndices[i] - 1
            if last[idx] == i+1 {
                available = append(available, nums[idx])
            } else {
                available = append(available, 0)
            }
        }

        sort.Ints(available)
        time := 0
        for _, val := range available {
            if val == 0 {
                time++
            } else {
                if val <= time {
                    // Mark
                } else {
                    time++
                }
            }
        }

        return time >= n
    }

    left, right := 1, m
    ans := -1

    for left <= right {
        mid := left + (right-left)/2
        if check(mid) {
            ans = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return ans
}