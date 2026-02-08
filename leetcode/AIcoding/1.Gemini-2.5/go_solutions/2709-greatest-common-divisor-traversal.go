package main

type DSU struct {
	parent []int
	size   []int
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	size := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
		size[i] = 1
	}
	return &DSU{parent: parent, size: size}
}

func (d *DSU) find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.find(d.parent[i])
	return d.parent[i]
}

func (d *DSU) union(i, j int) {
	rootI := d.find(i)
	rootJ := d.find(j)
	if rootI != rootJ {
		if d.size[rootI] < d.size[rootJ] {
			rootI, rootJ = rootJ, rootI
		}
		d.parent[rootJ] = rootI
		d.size[rootI] += d.size[rootJ]
	}
}

const MAX_VAL = 100001 // Max value in nums + 1
var spf [MAX_VAL]int   // smallest prime factor

var sieveInitialized bool

func initSieve() {
	for i := 2; i < MAX_VAL; i++ {
		spf[i] = i
	}
	for i := 2; i*i < MAX_VAL; i++ {
		if spf[i] == i { // i is prime
			for j := i * i; j < MAX_VAL; j += i {
				if spf[j] == j { // only update if not already found a smaller prime factor
					spf[j] = i
				}
			}
		}
	}
}

func getPrimeFactorsSieve(n int) []int {
	if !sieveInitialized {
		initSieve()
		sieveInitialized = true
	}

	factors := []int{}
	tempN := n
	for tempN > 1 {
		p := spf[tempN]
		factors = append(factors, p)
		for tempN%p == 0 {
			tempN /= p
		}
	}
	return factors
}

func canTraverseAllPairs(nums []int) bool {
	n := len(nums)

	if n == 1 {
		return true
	}

	// If any '1' exists in nums, it cannot share a common divisor > 1 with any other number.
	// Thus, if n > 1 and a '1' is present, it's impossible to connect all nodes.
	for _, num := range nums {
		if num == 1 {
			return false
		}
	}

	// DSU nodes: 0 to n-1 for array indices, n to n+MAX_VAL-1 for prime factors.
	// Prime factor 'p' maps to DSU node 'n + p'.
	dsu := newDSU(n + MAX_VAL)

	for i, num := range nums {
		factors := getPrimeFactorsSieve(num)
		for _, factor := range factors {
			// Union the current number's index 'i' with its prime factor 'factor'.
			// The prime factor is mapped to a DSU node 'n + factor'.
			dsu.union(i, n+factor)
		}
	}

	// Check if all original 'n' nodes (0 to n-1) are in the same connected component.
	// This can be done by checking if they all have the same root as node 0.
	rootOfFirstNode := dsu.find(0)
	for i := 1; i < n; i++ {
		if dsu.find(i) != rootOfFirstNode {
			return false
		}
	}

	return true
}