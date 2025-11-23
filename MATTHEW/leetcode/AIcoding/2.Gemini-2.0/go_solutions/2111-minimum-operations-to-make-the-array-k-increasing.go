func kIncreasing(arr []int, k int) int {
	n := len(arr)
	ans := 0
	for i := 0; i < k; i++ {
		sub := []int{}
		for j := i; j < n; j += k {
			sub = append(sub, arr[j])
		}
		ans += len(sub) - longestIncreasingSubsequenceLength(sub)
	}
	return ans
}

func longestIncreasingSubsequenceLength(arr []int) int {
	tail := []int{}
	for _, num := range arr {
		if len(tail) == 0 || num >= tail[len(tail)-1] {
			tail = append(tail, num)
		} else {
			l, r := 0, len(tail)-1
			for l < r {
				mid := l + (r-l)/2
				if tail[mid] <= num {
					l = mid + 1
				} else {
					r = mid
				}
			}
			tail[l] = num
		}
	}
	return len(tail)
}

func main() {}