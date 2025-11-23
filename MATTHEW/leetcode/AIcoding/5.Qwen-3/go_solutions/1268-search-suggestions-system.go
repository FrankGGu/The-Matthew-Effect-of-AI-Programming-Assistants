package main

func suggestedProducts(products []string, searchWord string) [][]string {
	sort.Strings(products)
	result := [][]string{}
	for i := 0; i < len(searchWord); i++ {
		temp := []string{}
		for j := 0; j < len(products); j++ {
			if i < len(products[j]) && products[j][i] == searchWord[i] {
				temp = append(temp, products[j])
				if len(temp) == 3 {
					break
				}
			}
		}
		result = append(result, temp)
	}
	return result
}