func minimizeMaximum(n int, div1 int, div2 int, maxVal int) int {
	low, high := 1, 2*n
	ans := high

	for low <= high {
		mid := low + (high-low)/2
		count1 := mid - mid/div1
		count2 := mid - mid/div2
		count12 := mid - mid/div1 - mid/div2 + mid/(div1*div2/gcd(div1, div2))

		if count1 >= n-count2 && count2 >= n-count1 && count12 >= 0 && count1 >= 0 && count2 >= 0 && count1+count2-count12 >= n {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
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