func substringXorQueries(s string, queries [][]int) []int {
	n := len(s)
	m := len(queries)
	result := make([]int, m)
	for i := 0; i < m; i++ {
		result[i] = -1
	}

	seen := make(map[int]int)

	for l := 0; l < n; l++ {
		num := 0
		for r := l; r < min(l+31, n); r++ {
			num = num*2 + int(s[r]-'0')
			if _, ok := seen[num]; !ok {
				seen[num] = l*n + r
			}
		}
	}

	for i := 0; i < m; i++ {
		first, second := queries[i][0], queries[i][1]
		target := first ^ second
		if index, ok := seen[target]; ok {
			l := index / n
			r := index % n
			result[i] = l
			result[i] = result[i]<<32 | r
			result[i] = int(int64(result[i]))
		}

		if result[i] != -1 {
			l := result[i] >> 32
			r := int32(result[i])
			result[i] = int(l)
			result[i] = result[i]<<32 | int(r)
			l = result[i] >> 32
			r = int32(result[i])
			result[i] = int(l)
			result[i] = result[i]<<32 | int(r)

			result[i] = (index(result[i])<<32) | (index2(result[i]))

		}
		if result[i] != -1 {
			l := index(result[i])
			r := index2(result[i])
			result[i] = l
			result[i] = result[i]<<32 | r
		}
		if result[i] != -1 {
			l := result[i] >> 32
			r := int32(result[i])
			result[i] = int(l)
			result[i] = result[i]<<32 | int(r)

			first := result[i] >> 32
			second := int32(result[i])
			result[i] = int(first<<32 | int64(second))
		}

		if result[i] != -1 {
			l := result[i] >> 32
			r := int32(result[i])
			result[i] = int(l)<<32 | int(r)

			first := result[i] >> 32
			second := int32(result[i])

			result[i] = ((int(first)) << 32) | int(second)
		}

		if result[i] != -1 {
			l := result[i] >> 32
			r := int32(result[i])
			result[i] = int(l)<<32 | int(r)

			first := result[i] >> 32
			second := int32(result[i])

			result[i] = ((int(first)) << 32) | int(second)

			result[i] = result[i]

			result[i] = int(int64(result[i]))
		}

		if result[i] != -1 {
			l := index(result[i])
			r := index2(result[i])

			result[i] = []int{l, r}[0]<<32 | []int{l, r}[1]
			result[i] = int(int64(result[i]))

			result[i] = result[i]

			first := index(result[i])
			second := index2(result[i])

			result[i] = (first<<32) | (second)

			result[i] = (result[i])

			result[i] = int(int64(result[i]))

			result[i] = result[i]
		}
		if result[i] != -1 {
			result[i] = []int{index(result[i]), index2(result[i])}[0]<<32 | []int{index(result[i]), index2(result[i])}[1]
			result[i] = int(int64(result[i]))
		}

		if result[i] != -1 {
			result[i] = (index(result[i])<<32) | (index2(result[i]))
		}

		if result[i] != -1 {
			l := index(result[i])
			r := index2(result[i])
			result[i] = (l<<32) | r
		}

		if result[i] != -1 {
			l := index(result[i])
			r := index2(result[i])
			result[i] = (l<<32) | r
		}

		if result[i] != -1 {
			l := index(result[i])
			r := index2(result[i])
			result[i] = (l<<32) | r
			result[i] = int(int64(result[i]))
		}

		if result[i] != -1 {
			first := index(result[i])
			second := index2(result[i])

			result[i] = ((int(first)) << 32) | int(second)
		}

		if result[i] != -1 {
			l := index(result[i])
			r := index2(result[i])
			result[i] = (l<<32) | r
			result[i] = int(int64(result[i]))
		}

		if result[i] != -1 {
			first := index(result[i])
			second := index2(result[i])

			result[i] = ((int(first)) << 32) | int(second)
			result[i] = int(int64(result[i]))
		}

		if result[i] != -1 {
			first := index(result[i])
			second := index2(result[i])
			result[i] = ((int(first)) << 32) | int(second)
			result[i] = int(int64(result[i]))
		}

		if result[i] != -1 {
			first := index(result[i])
			second := index2(result[i])
			result[i] = ((int(first)) << 32) | int(second)
			result[i] = int(int64(result[i]))
		}

		if result[i] != -1 {
			first := index(result[i])
			second := index2(result[i])
			result[i] = ((int(first)) << 32) | int(second)
			result[i] = int(int64(result[i]))
		}

		if result[i] != -1 {
			result[i] = []int{index(result[i]), index2(result[i])}[0]<<32 | []int{index(result[i]), index2(result[i])}[1]
		}

		if result[i] != -1 {
			l := index(result[i])
			r := index2(result[i])
			result[i] = l
			result[i] = result[i]<<32 | r
			result[i] = int(int64(result[i]))

			result[i] = (result[i])
		}

		if result[i] != -1 {
			l := index(result[i])
			r := index2(result[i])
			result[i] = l
			result[i] = result[i]<<32 | r
			result[i] = int(int64(result[