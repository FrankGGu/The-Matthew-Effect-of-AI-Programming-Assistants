import (
	"sort"
)

func maximumBeauty(flowers []int, newFlowers int64, target int, full int, partial int) int64 {
	sort.Ints(flowers)
	n := len(flowers)
	prefixSum := make([]int64, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + int64(flowers[i])
	}

	check := func(count int, newFlowers int64) bool {
		if count == 0 {
			return true
		}
		left, right := 0, n-1
		for left <= right {
			mid := left + (right-left)/2
			if flowers[mid] >= target {
				right = mid - 1
			} else {
				left = mid + 1
			}
		}

		neededFlowers := int64(0)
		for i := 0; i < count; i++ {
			neededFlowers += int64(target - flowers[i])
		}
		return neededFlowers <= newFlowers
	}

	maxFull := 0
	for i := n; i >= 0; i-- {
		remainingFlowers := newFlowers - int64(i)*int64(target-0)
		if remainingFlowers < 0 {
			continue
		}
		maxFull = i
		break
	}

	ans := int64(0)
	for i := 0; i <= maxFull; i++ {
		remainingFlowers := newFlowers - int64(i)*int64(target)
		if remainingFlowers < 0 {
			break
		}

		left, right := 0, n-i-1
		maxPartial := 0
		for left <= right {
			mid := left + (right-left)/2
			neededFlowers := int64(flowers[mid])*(int64(n-i-mid)) - (prefixSum[n-i] - prefixSum[mid])
			if neededFlowers <= remainingFlowers {
				maxPartial = flowers[mid]
				left = mid + 1
			} else {
				right = mid - 1
			}
		}

		l, r := 0, target-1
		maxPartialBeauty := 0
		for l <= r {
			mid := l + (r-l)/2
			neededFlowers := int64(mid)*(int64(n-i)) - (prefixSum[n] - prefixSum[i])

			if neededFlowers - (int64(i) * int64(target)) <= newFlowers {
				maxPartialBeauty = mid
				l = mid + 1
			}else{
				r = mid -1
			}
		}

		left, right = 0, target-1
		max_partial := 0
		for left <= right {
			mid := left + (right-left)/2
			cnt := n - i
			idx := sort.Search(n-i, func(j int) bool {
				return flowers[j] > mid
			})

			need := int64(mid)*int64(cnt) - (prefixSum[n] - prefixSum[i])
			if need <= newFlowers {
				max_partial = mid
				left = mid + 1
			} else {
				right = mid - 1
			}
		}

		if n-i > 0 {
			left, right = 0, target-1
			max_partial = 0
			for left <= right {
				mid := left + (right - left) / 2
				need := int64(0)
				add := int64(0)

				idx := sort.Search(n - i, func(j int) bool {
					return flowers[j] > mid
				})
				if idx == n - i {
					add = int64(0)
				}else {
					add = int64(flowers[idx])
				}

				need = int64(mid) * int64(n-i) - (prefixSum[n] - prefixSum[i])
				if need <= newFlowers {
					max_partial = mid
					left = mid + 1
				} else {
					right = mid - 1
				}

			}

			ans = maxInt64(ans, int64(i)*int64(full)+int64(max_partial)*int64(partial))
		} else {
			ans = maxInt64(ans, int64(i)*int64(full))
		}
	}

	return ans
}

func maxInt64(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}