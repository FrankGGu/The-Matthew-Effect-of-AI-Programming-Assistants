import "sort"

func makeSubKSumEqual(arr []int, k int) int64 {
	n := len(arr)
	k = gcd(n, k)
	ans := int64(0)
	for i := 0; i < k; i++ {
		temp := []int{}
		for j := i; j < n; j += k {
			temp = append(temp, arr[j])
		}
		sort.Ints(temp)
		median := temp[len(temp)/2]
		for _, num := range temp {
			ans += int64(abs(num - median))
		}
	}
	return ans
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}