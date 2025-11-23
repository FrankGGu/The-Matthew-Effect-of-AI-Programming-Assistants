import "sort"

func canDistribute(quantities []int, groups []int) bool {
	counts := make(map[int]int)
	for _, q := range quantities {
		counts[q]++
	}

	uniqueQuantities := []int{}
	for q := range counts {
		uniqueQuantities = append(uniqueQuantities, q)
	}

	freq := []int{}
	for _, q := range uniqueQuantities {
		freq = append(freq, counts[q])
	}

	sort.Sort(sort.Reverse(sort.IntSlice(groups)))

	n := len(groups)
	m := len(freq)

	dp := make([][]bool, m+1)
	for i := range dp {
		dp[i] = make([]bool, 1<<n)
	}

	dp[0][0] = true

	for i := 1; i <= m; i++ {
		for mask := 0; mask < (1 << n); mask++ {
			if !dp[i-1][mask] {
				continue
			}
			dp[i][mask] = true
			for submask := 0; submask < (1 << n); submask++ {
				if mask&submask != 0 {
					continue
				}
				sum := 0
				valid := true
				for j := 0; j < n; j++ {
					if (submask>>j)&1 == 1 {
						sum += groups[j]
					}
				}
				if sum > freq[i-1] {
					continue
				}

				dp[i][mask|submask] = dp[i-1][mask]
			}
		}

		for submask := 0; submask < (1 << n); submask++ {
				if dp[i-1][submask] {
					sum := 0
					valid := true
					for j := 0; j < n; j++ {
						if ((1<<n)-1-submask)>>j&1 == 1 {
							sum += groups[j]
						}
					}
					if sum >= freq[i-1] {

						newMask := 0

						if freq[i-1] == 0 {
							newMask = ((1<<n)-1-submask)
						} else {

							tempGroups := make([]int,0)
							tempMask := 0
							tempSum := 0

							for j:=0; j < n; j++ {
								if ((1<<n)-1-submask)>>j&1 == 1 {
									tempGroups = append(tempGroups, groups[j])
								}
							}