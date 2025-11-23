package main

func trailingZeroes(n int64) int64 {
	var count int64 = 0
	for n >= 5 {
		n /= 5
		count += n
	}
	return count
}

func findX(targetK int64) int64 {
	var low int64 = 0
	var high int64 = 5 * (targetK + 1)

	var ans int64 = 0

	for low <= high {
		mid := low + (high-low)/2
		zeros := trailingZeroes(mid)

		if zeros >= targetK {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}
	return ans
}

func preimageSizeFZF(k int) int {
	k64 := int64(k)

	return int(findX(k64+1) - findX(k64))
}