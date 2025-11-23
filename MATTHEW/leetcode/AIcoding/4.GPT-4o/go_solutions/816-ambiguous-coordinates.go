func ambiguousCoordinates(s string) []string {
    s = s[1 : len(s)-1]
    results := []string{}

    for i := 1; i < len(s); i++ {
        left := s[:i]
        right := s[i:]
        leftCoords := generateCoordinates(left)
        rightCoords := generateCoordinates(right)

        for _, l := range leftCoords {
            for _, r := range rightCoords {
                results = append(results, l+" "+r)
            }
        }
    }

    return results
}

func generateCoordinates(part string) []string {
    n := len(part)
    coordinates := []string{}

    if n == 1 || part[0] != '0' {
        coordinates = append(coordinates, part)
    }

    for i := 1; i < n; i++ {
        left := part[:i]
        right := part[i:]

        if (right[0] != '0' || len(right) == 1) && (left == "0" || left[0] != '0') {
            coordinates = append(coordinates, left+"."+right)
        }
    }

    return coordinates
}