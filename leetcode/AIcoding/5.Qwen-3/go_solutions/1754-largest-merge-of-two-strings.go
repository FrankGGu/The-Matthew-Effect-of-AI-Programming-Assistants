package main

func largestMerge(s1 string, s2 string) string {
	var merge []byte
	i, j := 0, 0
	for i < len(s1) && j < len(s2) {
		if s1[i:] > s2[j:] {
			merge = append(merge, s1[i])
			i++
		} else {
			merge = append(merge, s2[j])
			j++
		}
	}
	for i < len(s1) {
		merge = append(merge, s1[i])
		i++
	}
	for j < len(s2) {
		merge = append(merge, s2[j])
		j++
	}
	return string(merge)
}