package main

func isPossible(nums []int) bool {
	freq := make(map[int]int)
	want := make(map[int]int)

	for _, num := range nums {
		freq[num]++
	}

	for _, num := range nums {
		if freq[num] == 0 {
			continue
		}

		if want[num] > 0 {
			want[num]--
			want[num+1]++
			freq[num]--
		} else {
			if freq[num+1] > 0 && freq[num+2] > 0 {
				freq[num]--
				freq[num+1]--
				freq[num+2]--
				want[num+3]++
			} else {
				return false
			}
		}
	}

	return true
}