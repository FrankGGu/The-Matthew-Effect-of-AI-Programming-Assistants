package main

func minimumBoxes(weight []int) int {
    sort.Ints(weight)
    var total int
    var boxes int
    for i := len(weight) - 1; i >= 0; i-- {
        total += weight[i]
        boxes++
        if total >= 100 {
            return boxes
        }
    }
    return boxes
}