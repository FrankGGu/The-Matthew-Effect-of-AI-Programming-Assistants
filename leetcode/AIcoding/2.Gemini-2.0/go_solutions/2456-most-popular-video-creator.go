import "fmt"

func mostPopularCreator(creators []string, ids []string, views []int) []string {
	m := make(map[string]int)
	idMap := make(map[string]string)
	for i := 0; i < len(creators); i++ {
		m[creators[i]] += views[i]
		if _, ok := idMap[creators[i]]; !ok {
			idMap[creators[i]] = ids[i]
		} else {
			if views[i] > views[getIndex(ids, idMap[creators[i]])] {
				idMap[creators[i]] = ids[i]
			} else if views[i] == views[getIndex(ids, idMap[creators[i]])] {
				if ids[i] < idMap[creators[i]] {
					idMap[creators[i]] = ids[i]
				}
			}
		}
	}

	maxView := 0
	for _, v := range m {
		if v > maxView {
			maxView = v
		}
	}

	res := []string{}
	for k, v := range m {
		if v == maxView {
			res = append(res, k)
		}
	}
	return res
}

func getIndex(arr []string, target string) int {
	for i := 0; i < len(arr); i++ {
		if arr[i] == target {
			return i
		}
	}
	return -1
}