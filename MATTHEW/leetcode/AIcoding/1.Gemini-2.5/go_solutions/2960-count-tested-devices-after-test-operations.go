func countTestedDevices(batteryPercentages []int) int {
    testedCount := 0
    for i := 0; i < len(batteryPercentages); i++ {
        // Calculate the effective battery percentage for the current device.
        // This is its initial percentage minus the number of devices already tested,
        // as each tested device decreases subsequent