package main

func minProcessingTime(customers []int, n int) int {
    sort.Ints(customers)
    for i := 0; i < n; i++ {
        customers[i] = -customers[i]
    }
    sort.Ints(customers)
    max := 0
    for i := 0; i < n; i++ {
        if customers[i] > max {
            max = customers[i]
        }
    }
    return max
}