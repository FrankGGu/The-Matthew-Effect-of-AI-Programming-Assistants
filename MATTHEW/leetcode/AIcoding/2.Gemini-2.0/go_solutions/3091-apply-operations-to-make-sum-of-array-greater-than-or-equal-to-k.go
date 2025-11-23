import (
	"sort"
)

func kIncreasing(arr []int, k int) int {
	n := len(arr)
	ans := 0
	for i := 0; i < k; i++ {
		sub := []int{}
		for j := i; j < n; j += k {
			sub = append(sub, arr[j])
		}
		ans += len(sub) - lengthOfLIS(sub)
	}
	return ans
}

func lengthOfLIS(nums []int) int {
	tails := []int{}
	for _, num := range nums {
		i, j := 0, len(tails)
		for i < j {
			mid := (i + j) / 2
			if tails[mid] <= num {
				i = mid + 1
			} else {
				j = mid
			}
		}
		if i == len(tails) {
			tails = append(tails, num)
		} else {
			tails[i] = num
		}
	}
	return len(tails)
}

func checkArray(nums []int, operations [][]int, k int) bool {
	n := len(nums)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	for _, op := range operations {
		l, r, x := op[0], op[1], op[2]
		for i := l; i <= r; i++ {
			nums[i] += x
		}
		prefixSum = make([]int, n+1)
		for i := 0; i < n; i++ {
			prefixSum[i+1] = prefixSum[i] + nums[i]
		}
	}

	return prefixSum[n] >= k
}

func checkArrayOptimized(nums []int, operations [][]int, k int) bool {
    n := len(nums)
    diff := make([]int, n)

    for _, op := range operations {
        l, r, x := op[0], op[1], op[2]
        diff[l] += x
        if r+1 < n {
            diff[r+1] -= x
        }
    }

    sum := 0
    for i := 0; i < n; i++ {
        sum += diff[i]
        nums[i] += sum
    }

    arrSum := 0
    for _, num := range nums {
        arrSum += num
    }

    return arrSum >= k
}

func checkArrayUsingBinarySearch(nums []int, operations [][]int, k int) bool {
	n := len(nums)
	sum := 0
	for _, num := range nums {
		sum += num
	}

	for _, op := range operations {
		l, r, x := op[0], op[1], op[2]
		for i := l; i <= r; i++ {
			sum += x
		}
	}

	return sum >= k
}

func minOperations(nums []int, k int) int {
    n := len(nums)
    sort.Ints(nums)
    ans := 0
    i, j := 0, n-1
    for i < j {
        if nums[i] + nums[j] < k {
            ans++
            i += 2
            j--
        } else {
            i++
            j--
        }
    }
    return ans
}

func check(nums []int, k int) int {
    n := len(nums)
    sum := 0
    for _, num := range nums {
        sum += num
    }

    if sum >= k {
        return 0
    }

    sort.Ints(nums)
    ans := 0
    i, j := 0, n-1
    for i < j {
        if sum >= k {
            break
        }
        sum -= nums[i]
        sum -= nums[j]
        sum += k
        ans++
        i++
        j--
    }

    if sum < k {
        return -1
    }
    return ans
}

func minOperations(nums []int, k int) int {
    n := len(nums)
    sum := 0
    for _, num := range nums {
        sum += num
    }

    if sum >= k {
        return 0
    }

    sort.Ints(nums)
    ans := 0
    l, r := 0, n-1
    for l < r {
        if sum >= k {
            break
        }
        sum -= nums[l]
        sum -= nums[r]
        sum += k
        ans++
        l++
        r--
    }
    if sum < k {
        return -1
    }
    return ans
}