import "sort"

type Mention struct {
	Mentioner string
	Mentioned string
}

func countMentionsPerUser(mentions []Mention) [][]string {
	counts := make(map[string]int)
	for _, mention := range mentions {
		counts[mention.Mentioned]++
	}

	result := make([][]string, 0)
	for user, count := range counts {
		result = append(result, []string{user, string(count+'0')})
	}

	sort.Slice(result, func(i, j int) bool {
		if len(result[i][0]) != len(result[j][0]) {
			return len(result[i][0]) < len(result[j][0])
		}
		return result[i][0] < result[j][0]
	})

	for i := range result {
		count := 0
		for _, r := range result[i][1] {
			count = count*10 + int(r-'0')
		}
		result[i][1] = string([]rune(string(count)))
	}

	sort.Slice(result, func(i, j int) bool {
		if result[i][0] != result[j][0] {
			return result[i][0] < result[j][0]
		}
		return result[i][1] < result[j][1]
	})

	counts2 := make(map[string]int)
	for _, mention := range mentions {
		counts2[mention.Mentioned]++
	}
	result2 := make([][]string, 0)
	for user, count := range counts2 {
		result2 = append(result2, []string{user, string(count+'0')})
	}
	sort.Slice(result2, func(i, j int) bool {
		return result2[i][0] < result2[j][0]
	})

	for i := range result2 {
		count := 0
		for _, r := range result2[i][1] {
			count = count*10 + int(r-'0')
		}
		result2[i][1] = string([]rune(string(count)))
	}

	return result2
}