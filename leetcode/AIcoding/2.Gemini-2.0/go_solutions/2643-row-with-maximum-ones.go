func rowAndMaximumOnes(mat [][]int) []int {
    maxOnes := 0
    maxRow := 0
    for i, row := range mat {
        ones := 0
        for _, val := range row {
            if val == 1 {
                ones++
            }
        }
        if ones > maxOnes {
            maxOnes = ones
            maxRow = i
        }
    }
    return []int{maxRow, maxOnes}
}