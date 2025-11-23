func garbageCollection(garbage []string, travel []int) int {
    lastM, lastP, lastG := 0, 0, 0
    time := 0

    for i := 0; i < len(garbage); i++ {
        for _, c := range garbage[i] {
            switch c {
            case 'M':
                lastM = i
            case 'P':
                lastP = i
            case 'G':
                lastG = i
            }
            time++
        }
    }

    for i := 1; i < len(travel); i++ {
        travel[i] += travel[i-1]
    }

    if lastM > 0 {
        time += travel[lastM-1]
    }
    if lastP > 0 {
        time += travel[lastP-1]
    }
    if lastG > 0 {
        time += travel[lastG-1]
    }

    return time
}