func countElements(arr []int) int {
    minVal, maxVal := arr[0], arr[0]
    for _, num := range arr {
        if num < minVal {
            minVal = num
        }
        if num > maxVal {
            maxVal = num
        }
    }
    count := 0
    for _, num := range arr {
        if num > minVal && num < maxVal {
            count++
        }
    }
    return count
}