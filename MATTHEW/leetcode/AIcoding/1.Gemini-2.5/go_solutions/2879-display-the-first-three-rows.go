package main

func displayFirstThreeRows(data [][]string) [][]string {
	if len(data) == 0 {
		return [][]string{}
	}
	if len(data) < 3 {
		return data
	}
	return data[:3]
}