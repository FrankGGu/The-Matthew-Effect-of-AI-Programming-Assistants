func isValidSerialization(preorder string) bool {
	nodes := strings.Split(preorder, ",")
	slots := 1
	for _, node := range nodes {
		slots--
		if slots < 0 {
			return false
		}
		if node != "#" {
			slots += 2
		}
	}
	return slots == 0
}

import "strings"