func adventureCamp(expeditions []string) int {
    known := make(map[string]bool)
    if len(expeditions[0]) > 0 {
        camps := strings.Split(expeditions[0], "->")
        for _, camp := range camps {
            known[camp] = true
        }
    }

    maxNew := 0
    res := -1

    for i := 1; i < len(expeditions); i++ {
        if len(expeditions[i]) == 0 {
            continue
        }
        camps := strings.Split(expeditions[i], "->")
        newCamps := 0
        tempKnown := make(map[string]bool)
        for _, camp := range camps {
            if !known[camp] && !tempKnown[camp] {
                newCamps++
                tempKnown[camp] = true
            }
        }
        if newCamps > maxNew {
            maxNew = newCamps
            res = i
        }
        for camp := range tempKnown {
            known[camp] = true
        }
    }

    return res
}