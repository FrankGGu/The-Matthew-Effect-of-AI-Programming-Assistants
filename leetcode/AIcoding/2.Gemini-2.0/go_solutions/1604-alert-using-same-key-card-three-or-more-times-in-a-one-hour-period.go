import "sort"

func alertNames(keyName []string, keyTime []string) []string {
	m := make(map[string][]int)
	for i := 0; i < len(keyName); i++ {
		h := int(keyTime[i][0]-'0')*10 + int(keyTime[i][1]-'0')
		min := int(keyTime[i][3]-'0')*10 + int(keyTime[i][4]-'0')
		m[keyName[i]] = append(m[keyName[i]], h*60+min)
	}

	res := []string{}
	for name, times := range m {
		sort.Ints(times)
		for i := 0; i < len(times)-2; i++ {
			if times[i+2]-times[i] <= 60 {
				res = append(res, name)
				break
			}
		}
	}

	sort.Strings(res)
	uniqueRes := []string{}
	if len(res) > 0 {
		uniqueRes = append(uniqueRes, res[0])
		for i := 1; i < len(res); i++ {
			if res[i] != res[i-1] {
				uniqueRes = append(uniqueRes, res[i])
			}
		}
	}

	return uniqueRes
}