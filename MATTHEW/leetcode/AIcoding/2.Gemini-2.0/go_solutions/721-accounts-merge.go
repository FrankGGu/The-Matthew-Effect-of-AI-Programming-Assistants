func accountsMerge(accounts [][]string) [][]string {
	emailToIndex := make(map[string]int)
	emailToName := make(map[string]string)
	var uf []int

	find := func(x int) int {
		if uf[x] == x {
			return x
		}
		uf[x] = find(uf[x])
		return uf[x]
	}

	union := func(x, y int) {
		x = find(x)
		y = find(y)
		if x != y {
			uf[x] = y
		}
	}

	n := len(accounts)
	uf = make([]int, n)
	for i := range uf {
		uf[i] = i
	}

	for i, account := range accounts {
		name := account[0]
		for j := 1; j < len(account); j++ {
			email := account[j]
			if _, ok := emailToIndex[email]; !ok {
				emailToIndex[email] = i
				emailToName[email] = name
			} else {
				union(i, emailToIndex[email])
			}
		}
	}

	indexToEmails := make(map[int][]string)
	for email, index := range emailToIndex {
		root := find(index)
		indexToEmails[root] = append(indexToEmails[root], email)
	}

	var res [][]string
	for index, emails := range indexToEmails {
		name := accounts[index][0]
		sort.Strings(emails)
		account := []string{name}
		account = append(account, emails...)
		res = append(res, account)
	}

	return res
}

import "sort"