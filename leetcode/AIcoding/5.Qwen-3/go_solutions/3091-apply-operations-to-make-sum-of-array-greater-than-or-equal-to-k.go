package main

func minOperations(integers []int, k int) int {
    sort.Ints(integers)
    operations := 0
    for len(integers) > 1 {
        a := integers[0]
        b := integers[1]
        if a + b >= k {
            return operations
        }
        integers = append(integers[:1], integers[2:]...)
        integers = append(integers, a+b)
        operations++
    }
    return operations
}