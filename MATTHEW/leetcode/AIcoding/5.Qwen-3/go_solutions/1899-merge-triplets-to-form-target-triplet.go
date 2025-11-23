package main

func canFormTriplet(triplets [][]int, target []int) bool {
    for i := 0; i < len(triplets); i++ {
        if triplets[i][0] > target[0] || triplets[i][1] > target[1] || triplets[i][2] > target[2] {
            continue
        }
        if triplets[i][0] == target[0] && triplets[i][1] == target[1] && triplets[i][2] == target[2] {
            return true
        }
    }
    return false
}