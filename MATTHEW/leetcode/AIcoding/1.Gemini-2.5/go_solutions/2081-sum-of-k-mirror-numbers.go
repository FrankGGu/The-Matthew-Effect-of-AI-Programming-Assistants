import (
	"container/heap"
	"strconv"
)

func isPalindromeBaseK(num int64, k int) bool {
	if num == 0 {
		return true // 0 is considered a palindrome
	}
	digits := []int{}
	for num > 0 {
		digits = append(digits, int(num%int64(k)))
		num /= int64(k)
	}
	// Check if digits slice is a palindrome
	l, r := 0, len(digits)-1
	for l < r {
		if digits[l] != digits[r] {
			return false
		}
		l++
		r--
	}
	return true
}

func reverse(s string) string {
	r := []rune(s)
	for i, j := 0, len(r)-1; i < j; i, j = i+1, j-1 {
		r[i], r[j] = r[j], r[i]
	}
	return string(r)
}

type Int64Heap []int64

func (h Int64Heap) Len() int           { return len(h) }
func (h Int64Heap) Less(i, j int) bool { return h[i] < h[j] }
func (h Int64Heap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *Int64Heap) Push(x interface{}) {
	*h = append(*h, x.(int64))
}

func (h *Int64Heap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func sumOfKMirrorNumbers(n int, k int) int64 {
	var sum int64
	kMirrorNumbersCount := 0

	pq := &Int64Heap{}
	heap.Init(pq)

	// 'seen' map keeps track of base-10 palindromes already added to the heap
	// to avoid duplicates and re-processing.
	seen := make(map[int64]bool)

	// 'i' represents the first half of the base-10 palindrome.
	// We generate palindromes by iterating 'i' and constructing both
	// odd-length and even-length palindromes from it.
	// These palindromes are then added to a min-heap to be processed in increasing order.
	i := int64(1)
	for kMirrorNumbersCount < n {
		s_i := strconv.FormatInt(i, 10)

		// Construct odd-length palindrome: s_i + reverse(s_i without last digit)
		p_odd_str := s_i + reverse(s_i[:len(s_i)-1])
		p_odd, _ := strconv.ParseInt(p_odd_str, 10, 64)
		if !seen[p_odd] {
			heap.Push(pq, p_odd)
			seen[p_odd] = true
		}

		// Construct even-length palindrome: s_i + reverse(s_i)
		p_even_str := s_i + reverse(s_i)
		p_even, _ := strconv.ParseInt(p_even_str, 10, 64)
		if !seen[p_even] {
			heap.Push(pq, p_even)
			seen[p_even] = true
		}

		i++ // Move to the next first half

		// Process palindromes from the heap until we find 'n' k-mirror numbers
		// or the heap is empty (meaning we need to generate more candidates).
		for pq.Len() > 0 && kMirrorNumbersCount < n {
			curr := heap.Pop(pq).(int64)

			// Check if the current base-10 palindrome is also a base-k palindrome
			if isPalindromeBaseK(curr, k) {
				sum += curr
				kMirrorNumbersCount++
			}
		}
	}

	return sum
}