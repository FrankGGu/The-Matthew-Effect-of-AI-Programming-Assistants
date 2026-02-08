package main

var memo map[string]bool
var allowedMap map[string][]byte

func pyramidTransition(bottom string, allowed []string) bool {
	memo = make(map[string]bool)
	allowedMap = make(map[string][]byte)

	for _, s := range allowed {
		key := s[0:2]
		allowedMap[key] = append(allowedMap[key], s[2])
	}

	return dfs(bottom)
}

func dfs(currentLayer string) bool {
	if len(currentLayer) == 1 {
		return true
	}

	if res, ok := memo[currentLayer]; ok {
		return res
	}

	var nextLayerChars []byte

	var buildNextLayer func(idx int) bool
	buildNextLayer = func(idx int) bool {
		if idx == len(currentLayer)-1 {
			nextLayerStr := string(nextLayerChars)
			if dfs(nextLayerStr) {
				return true
			}
			return false
		}

		leftChar := currentLayer[idx]
		rightChar := currentLayer[idx+1]
		key := string(leftChar) + string(rightChar)

		if tops, ok := allowedMap[key]; ok {
			for _, topChar := range tops {
				nextLayerChars = append(nextLayerChars, topChar)
				if buildNextLayer(idx + 1) {
					return true
				}
				nextLayerChars = nextLayerChars[:len(nextLayerChars)-1]
			}
		}
		return false
	}

	result := buildNextLayer(0)
	memo[currentLayer] = result
	return result
}