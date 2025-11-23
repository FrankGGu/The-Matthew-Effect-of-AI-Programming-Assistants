func lengthLongestPath(input string) int {
    maxLength := 0
    pathLengths := make([]int, 0)

    for _, line := range strings.Split(input, "\n") {
        depth := strings.Count(line, "\t")
        line = strings.TrimPrefix(line, strings.Repeat("\t", depth))

        if strings.Contains(line, ".") {
            if depth == 0 {
                if len(pathLengths) == 0 {
                    pathLengths = append(pathLengths, len(line))
                } else {
                    pathLengths[depth] = pathLengths[depth-1] + len(line) + 1
                }
            } else {
                for len(pathLengths) <= depth {
                    pathLengths = append(pathLengths, 0)
                }
                pathLengths[depth] = pathLengths[depth-1] + len(line) + 1
            }
            maxLength = max(maxLength, pathLengths[depth])
        } else {
            for len(pathLengths) <= depth {
                pathLengths = append(pathLengths, 0)
            }
            pathLengths[depth] = pathLengths[depth-1] + len(line) + 1
        }
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}