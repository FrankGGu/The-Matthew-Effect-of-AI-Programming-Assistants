func minimumRefill(plants []int, capacityA int, capacityB int) int {
    totalRefills := 0
    n := len(plants)
    a, b := capacityA, capacityB

    for i, j := 0, n-1; i <= j; i, j = i+1, j-1 {
        if i == j {
            if a < plants[i] && b < plants[j] {
                totalRefills++
            }
        } else {
            if a < plants[i] {
                totalRefills++
                a = capacityA
            }
            a -= plants[i]

            if b < plants[j] {
                totalRefills++
                b = capacityB
            }
            b -= plants[j]
        }
    }

    return totalRefills
}