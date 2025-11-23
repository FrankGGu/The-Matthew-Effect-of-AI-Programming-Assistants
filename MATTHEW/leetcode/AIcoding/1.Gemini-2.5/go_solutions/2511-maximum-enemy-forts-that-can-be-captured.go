func maximumEnemyForts(forts []int) int {
    maxCaptured := 0
    currentStartFortType := 0 // 1 for my fort, -1 for enemy fort, 0 for no active sequence
    currentEmptyCount := 0

    for _, fort := range forts {
        if fort == 0 {
            //