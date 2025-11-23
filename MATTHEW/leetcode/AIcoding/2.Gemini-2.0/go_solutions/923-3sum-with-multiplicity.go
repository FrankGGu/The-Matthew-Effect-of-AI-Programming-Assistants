func threeSumMulti(arr []int, target int) int {
	count := make(map[int]int)
	for _, num := range arr {
		count[num]++
	}

	keys := make([]int, 0, len(count))
	for k := range count {
		keys = append(keys, k)
	}

	ans := 0
	mod := 1000000007

	for i := 0; i < len(keys); i++ {
		for j := i; j < len(keys); j++ {
			k := target - keys[i] - keys[j]
			if k < keys[j] {
				continue
			}
			if _, ok := count[k]; !ok {
				continue
			}

			if keys[i] == keys[j] && keys[j] == k {
				ans += count[keys[i]] * (count[keys[i]] - 1) * (count[keys[i]] - 2) / 6
			} else if keys[i] == keys[j] && keys[j] != k {
				ans += count[keys[i]] * (count[keys[i]] - 1) / 2 * count[k]
			} else if keys[i] != keys[j] && keys[j] == k {
				ans += count[keys[i]] * count[keys[j]] * (count[keys[j]] - 1) / 2
			} else if keys[i] < keys[j] && keys[j] < k {
				ans += count[keys[i]] * count[keys[j]] * count[k]
			}
			ans %= mod
		}
	}

	return ans
}