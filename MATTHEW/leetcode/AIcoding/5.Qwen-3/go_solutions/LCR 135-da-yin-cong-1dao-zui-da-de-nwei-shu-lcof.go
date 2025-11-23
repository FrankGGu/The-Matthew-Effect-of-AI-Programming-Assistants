package main

func countAndSay(n int) string {
	if n == 1 {
		return "1"
	}
	prev := countAndSay(n - 1)
	result := ""
	i := 0
	for i < len(prev) {
		count := 1
		j := i + 1
		for j < len(prev) && prev[j] == prev[i] {
			count++
			j++
		}
		result += strconv.Itoa(count) + string(prev[i])
		i += count
	}
	return result
}