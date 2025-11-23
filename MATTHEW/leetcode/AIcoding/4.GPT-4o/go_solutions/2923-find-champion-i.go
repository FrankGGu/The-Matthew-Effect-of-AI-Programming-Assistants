func findChampion(titles []string) string {
    titleCount := make(map[string]int)
    maxCount := 0
    champion := ""

    for _, title := range titles {
        titleCount[title]++
        if titleCount[title] > maxCount {
            maxCount = titleCount[title]
            champion = title
        }
    }

    return champion
}