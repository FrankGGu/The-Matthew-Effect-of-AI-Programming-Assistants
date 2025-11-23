import "sort"

func minimalKSum(nums []int, k int) int64 {
	sort.Ints(nums)
	var sum int64
	last := 0
	for _, num := range nums {
		if num <= last {
			continue
		}
		if num-last-1 >= k {
			sum += int64(last+1+last+k) * int64(k) / 2
			k = 0
			break
		} else {
			count := num - last - 1
			sum += int64(last+1+num-1) * int64(count) / 2
			k -= count
			last = num
		}
	}
	if k > 0 {
		sum += int64(last+1+last+k) * int64(k) / 2
	}
	return sum
}