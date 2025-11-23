package main

func secondHighest(s string) int {
	max1 := -1
	max2 := -1
	for _, c := range s {
		if c >= '0' && c <= '9' {
			num := int(c - '0')
			if num > max1 {
				max2 = max1
				max1 = num
			} else if num < max1 && num > max2 {
				max2 = num
			}
		}
	}
	return max2
}