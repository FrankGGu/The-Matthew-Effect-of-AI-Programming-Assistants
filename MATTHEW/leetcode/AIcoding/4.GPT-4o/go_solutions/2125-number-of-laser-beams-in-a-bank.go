func numberOfBeams(bank []string) int {
    count := 0
    prevDevices := 0

    for _, row := range bank {
        currentDevices := 0
        for _, ch := range row {
            if ch == '1' {
                currentDevices++
            }
        }
        if currentDevices > 0 {
            count += prevDevices * currentDevices
            prevDevices = currentDevices
        }
    }

    return count
}