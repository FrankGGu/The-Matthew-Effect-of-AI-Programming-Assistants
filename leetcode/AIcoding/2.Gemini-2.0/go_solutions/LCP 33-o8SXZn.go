func storeWater(bucket []int, vat []int) int {
	n := len(bucket)
	maxVat := 0
	for _, v := range vat {
		if v > maxVat {
			maxVat = v
		}
	}
	if maxVat == 0 {
		return 0
	}

	ans := 100000
	for k := 1; k <= maxVat; k++ {
		if k > ans {
			break
		}
		ops := k
		for i := 0; i < n; i++ {
			need := (vat[i] + k - 1) / k
			if need > bucket[i] {
				ops += need - bucket[i]
			}
		}
		if ops < ans {
			ans = ops
		}
	}

	return ans
}