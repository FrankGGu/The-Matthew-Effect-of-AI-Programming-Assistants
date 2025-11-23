func mergeTriplets(triplets [][]int, target []int) bool {
    canForm := make([]bool, 3)
    for _, triplet := range triplets {
        if triplet[0] > target[0] || triplet[1] > target[1] || triplet[2] > target[2] {
            continue
        }
        for i := 0; i < 3; i++ {
            if triplet[i] == target[i] {
                canForm[i] = true
            }
        }
    }
    return canForm[0] && canForm[1] && canForm[2]
}