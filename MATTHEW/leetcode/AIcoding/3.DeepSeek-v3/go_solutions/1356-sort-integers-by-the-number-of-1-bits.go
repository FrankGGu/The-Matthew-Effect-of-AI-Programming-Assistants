func sortByBits(arr []int) []int {
    countBits := func(num int) int {
        count := 0
        for num > 0 {
            count += num & 1
            num >>= 1
        }
        return count
    }

    sort.Slice(arr, func(i, j int) bool {
        countI := countBits(arr[i])
        countJ := countBits(arr[j])
        if countI == countJ {
            return arr[i] < arr[j]
        }
        return countI < countJ
    })

    return arr
}