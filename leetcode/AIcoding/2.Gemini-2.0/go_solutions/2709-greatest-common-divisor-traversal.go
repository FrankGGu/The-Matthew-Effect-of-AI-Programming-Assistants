func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func primeFactors(n int) map[int]bool {
	factors := make(map[int]bool)
	for i := 2; i*i <= n; i++ {
		for n%i == 0 {
			factors[i] = true
			n /= i
		}
	}
	if n > 1 {
		factors[n] = true
	}
	return factors
}

func canTraverseAllPairs(nums []int) bool {
	n := len(nums)
	if n == 1 {
		return true
	}

	parent := make([]int, n)
	for i := range parent {
		parent[i] = i
	}

	var find func(int) int
	find = func(i int) int {
		if parent[i] == i {
			return i
		}
		parent[i] = find(parent[i])
		return parent[i]
	}

	union := func(i, j int) {
		rootI := find(i)
		rootJ := find(j)
		if rootI != rootJ {
			parent[rootI] = rootJ
		}
	}

	factorMap := make(map[int][]int)
	for i, num := range nums {
		if num == 1 {
			return false
		}
		factors := primeFactors(num)
		for factor := range factors {
			factorMap[factor] = append(factorMap[factor], i)
		}
	}

	for _, indices := range factorMap {
		for i := 1; i < len(indices); i++ {
			union(indices[0], indices[i])
		}
	}

	count := 0
	for i := range parent {
		if parent[i] == i {
			count++
		}
	}

	return count == 1
}