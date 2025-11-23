package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"sort"
)

const MAX_A = 100000 // Maximum possible value of nums[i]

var (
	phi  []int
	divs [][]int
)

func precompute() {
	phi = make([]int, MAX_A+1)
	for i := 0; i <= MAX_A; i++ {
		phi[i] = i
	}
	for i := 2; i <= MAX_A; i++ {
		if phi[i] == i { // i is prime
			for j := i; j <= MAX_A; j += i {
				phi[j] -= phi[j] / i
			}
		}
	}

	divs = make([][]int, MAX_A+1)
	for i := 1; i <= MAX_A; i++ {
		for j := i; j <= MAX_A; j += i {
			divs[j] = append(divs[j], i)
		}
	}
}

type Query struct {
	l, r, idx, block int
}

var (
	nums        []int
	counts      []int // counts[d] stores how many numbers in the current window are multiples of d
	current_ans int64
)

func add(idx int) {
	val := nums[idx]
	for _, d := range divs[val] {
		current_ans += int64(phi[d]) * int64(counts[d])
		counts[d]++
	}
}

func remove(idx int) {
	val := nums[idx]
	for _, d := range divs[val] {
		counts[d]--
		current_ans -= int64(phi[d]) * int64(counts[d])
	}
}

func solve() {
	reader := bufio.NewReader(os.Stdin)
	writer := bufio.NewWriter(os.Stdout)
	defer writer.Flush()

	var n int
	fmt.Fscan(reader, &n)

	nums = make([]int, n)
	for i := 0; i < n; i++ {
		fmt.Fscan(reader, &nums[i])
	}

	var q int
	fmt.Fscan(reader, &q)

	queries := make([]Query, q)
	blockSize := int(math.Sqrt(float64(n)))
	if blockSize == 0 { // Handle small N, ensure blockSize is at least 1
		blockSize = 1
	}

	for i := 0; i < q; i++ {
		fmt.Fscan(reader, &queries[i].l, &queries[i].r)
		queries[i].l-- // 0-indexed
		queries[i].r-- // 0-indexed
		queries[i].idx = i
		queries[i].block = queries[i].l / blockSize
	}

	sort.Slice(queries, func(i, j int) bool {
		if queries[i].block != queries[j].block {
			return queries[i].block < queries[j].block
		}
		if queries[i].block%2 == 0 {
			return queries[i].r < queries[j].r
		}
		return queries[i].r > queries[j].r
	})

	answers := make([]int64, q)
	counts = make([]int, MAX_A+1)
	current_ans = 0

	currentL, currentR := 0, -1 // Current window is [currentL, currentR]

	for _, query := range queries {
		targetL, targetR := query.l, query.r

		for currentL > targetL {
			currentL--
			add(currentL)
		}
		for currentR < targetR {
			currentR++
			add(currentR)
		}
		for currentL < targetL {
			remove(currentL)
			currentL++
		}
		for currentR > targetR {
			remove(currentR)
			currentR--
		}
		answers[query.idx] = current_ans
	}

	for _, ans := range answers {
		fmt.Fprintln(writer, ans)
	}
}

func main() {
	precompute()
	solve()
}