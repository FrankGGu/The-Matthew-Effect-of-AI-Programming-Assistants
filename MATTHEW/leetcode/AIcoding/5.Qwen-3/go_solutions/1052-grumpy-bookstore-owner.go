package main

func maxSatisfied(customers []int, grumpy []int, X int) int {
    n := len(customers)
    satisfy := 0
    for i := 0; i < n; i++ {
        if grumpy[i] == 0 {
            satisfy += customers[i]
        }
    }

    maxAdd := 0
    add := 0
    for i := 0; i < X; i++ {
        if grumpy[i] == 1 {
            add += customers[i]
        }
    }
    maxAdd = add

    for i := X; i < n; i++ {
        if grumpy[i] == 1 {
            add += customers[i]
        }
        if grumpy[i-X] == 1 {
            add -= customers[i-X]
        }
        if add > maxAdd {
            maxAdd = add
        }
    }

    return satisfy + maxAdd
}