package main

func addOperators(num string, target int) []string {
	var result []string
	helper(num, 0, "", 0, 0, target, &result)
	return result
}

func helper(num string, index int, path string, prevNum int, currVal int, target int, result *[]string) {
	if index == len(num) {
		if currVal == target {
			*result = append(*result, path)
		}
		return
	}
	for i := index; i < len(num); i++ {
		if i > index && num[index] == '0' {
			break
		}
		currentStr := num[index:i+1]
		currentNum, _ := strconv.Atoi(currentStr)
		if index == 0 {
			helper(num, i+1, currentStr, currentNum, currentNum, target, result)
		} else {
			helper(num, i+1, path+"+"+currentStr, currentNum, currVal+currentNum, target, result)
			helper(num, i+1, path+"-"+currentStr, -currentNum, currVal-currentNum, target, result)
			helper(num, i+1, path+"*"+currentStr, prevNum*currentNum, currVal-prevNum+prevNum*currentNum, target, result)
		}
	}
}