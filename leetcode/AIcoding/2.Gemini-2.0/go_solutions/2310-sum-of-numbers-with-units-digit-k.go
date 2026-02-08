func sumOfMultiples(n int, k int) int {
	if k > n {
		return 0
	}

	count := n / k
	sum := 0
	for i := 1; i <= count; i++ {
		if i*k%10 == k || k == 0 {
			sum += i * k
		} else if k != 0 && i*k > n{
			break
		}
	}
	if k == 0 && n >= 0 {
		return 0
	}
	if k > n {
		return 0
	}

	maxMultiplier := n / k
	if k > n {
		return 0
	}

	sum = 0

	for i := 1; i <= maxMultiplier; i++ {
		if (i*k) <= n && (i*k)%10 == k {
			sum += i*k
		}
	}

	if sum == 0 && k != 0 {
		can := false
		for i := 1; i <= n; i++ {
			if i%10 == k {
				can = true
				break
			}
		}
		if !can {
			return -1
		}
	}

	return sum
}