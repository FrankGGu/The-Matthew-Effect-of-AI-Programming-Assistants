import "math"

func maxDistance(arrays [][]int) int {
    maxDist := 0

    // Initialize minVal and maxVal with the first array's minimum and maximum elements.
    // Since each array is sorted, arrays[0][0] is the minimum and arrays[0][len(arrays[0])-1] is the maximum.
    minVal := arrays[0][0]
    maxVal := arrays[0][len(arrays[0])-1]

    // Iterate through the arrays starting from the second one (index 1).
    for i := 1; i < len(arrays); i++ {
        currentMin := arrays[i][0]
        currentMax := arrays[i][len(arrays[i])-1]

        // Calculate the potential maximum distance between the current array's max/min
        // and the overall min/max found so far from previous arrays.
        // We take the absolute difference to ensure positive distance.
        // math.Abs works with float64, so we cast to float64 and back to int.
        // Alternatively, one could implement a custom abs(int) function.
        dist1 := int(math.Abs(float64(currentMax - minVal)))
        dist2 := int(math.Abs(float64(currentMin - maxVal)))

        // Update the overall maximum distance found.
        maxDist = int(math.Max(float64(maxDist), float64(dist1)))
        maxDist = int(math.Max(float64(maxDist), float64(dist2)))

        // Update the overall minimum and maximum values encountered across all arrays processed so far.
        minVal = int(math.Min(float64(minVal), float64(currentMin)))
        maxVal = int(math.Max(float64(maxVal), float64(currentMax)))
    }

    return maxDist
}