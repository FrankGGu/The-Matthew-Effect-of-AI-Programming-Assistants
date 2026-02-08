import (
	"sort"
	"strconv"
)

func getPermutation(n int, k int) string {
	factorial := make([]int, n+1)
	factorial[0] = 1
	for i := 1; i <= n; i++ {
		factorial[i] = factorial[i-1] * i
	}

	nums := make([]int, n)
	for i := 0; i < n; i++ {
		nums[i] = i + 1
	}

	k--
	result := ""
	for i := n; i >= 1; i-- {
		index := k / factorial[i-1]
		k %= factorial[i-1]
		result += strconv.Itoa(nums[index])
		nums = append(nums[:index], nums[index+1:]...)
	}

	return result
}

func getKthPermutation(num string, k int) string {
	n := len(num)
	nums := make([]int, n)
	for i := 0; i < n; i++ {
		nums[i] = int(num[i] - '0')
	}

	permutations := []string{}

	var permute func(arr []int, l, r int)
	permute = func(arr []int, l, r int) {
		if l == r {
			s := ""
			for i := 0; i < len(arr); i++ {
				s += strconv.Itoa(arr[i])
			}
			permutations = append(permutations, s)
			return
		}
		for i := l; i <= r; i++ {
			arr[l], arr[i] = arr[i], arr[l]
			permute(arr, l+1, r)
			arr[l], arr[i] = arr[i], arr[l]
		}
	}

	permute(nums, 0, n-1)

	sort.Strings(permutations)

	return permutations[k-1]
}

func minSwaps(num string, k int) int {
	target := getKthPermutation(num, k+1)
	original := []rune(num)
	targetRune := []rune(target)

	swaps := 0
	for i := 0; i < len(original); i++ {
		if original[i] != targetRune[i] {
			for j := i + 1; j < len(original); j++ {
				if original[j] == targetRune[i] {
					for l := j; l > i; l-- {
						original[l], original[l-1] = original[l-1], original[l]
						swaps++
					}
					break
				}
			}
		}
	}

	return swaps
}