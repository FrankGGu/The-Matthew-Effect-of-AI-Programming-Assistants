func countTestedDevices(batteryPercentages []int) int {
    count := 0
    for i := 0; i < len(batteryPercentages); i++ {
        if batteryPercentages[i] > 0 {
            count++
            for j := i + 1; j < len(batteryPercentages); j++ {
                if batteryPercentages[j] > 0 {
                    batteryPercentages[j]--
                }
            }
        }
    }
    return count
}