import "sort"

func suggestedProducts(products []string, searchWord string) [][]string {
	sort.Strings(products)
	res := [][]string{}
	prefix := ""
	for i := 0; i < len(searchWord); i++ {
		prefix += string(searchWord[i])
		temp := []string{}
		count := 0
		for _, p := range products {
			if len(p) >= len(prefix) && p[:len(prefix)] == prefix {
				temp = append(temp, p)
				count++
				if count == 3 {
					break
				}
			}
		}
		res = append(res, temp)
	}
	return res
}