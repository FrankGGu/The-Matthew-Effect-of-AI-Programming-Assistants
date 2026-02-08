import "sort"

func videoStitching(clips [][]int, time int) int {
	sort.Slice(clips, func(i, j int) bool {
		if clips[i][0] != clips[j][0] {
			return clips[i][0] < clips[j][0]
		}
		return clips[i][1] > clips[j][1]
	})

	count := 0
	currEnd := 0
	nextEnd := 0
	i := 0

	for i < len(clips) && currEnd < time {
		if clips[i][0] > currEnd {
			return -1
		}

		for i < len(clips) && clips[i][0] <= currEnd {
			nextEnd = max(nextEnd, clips[i][1])
			i++
		}

		count++
		currEnd = nextEnd
	}

	if currEnd < time {
		return -1
	}

	return count
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}