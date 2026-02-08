package main

func maxStrength(grades []int) int {
    if len(grades) == 1 {
        return grades[0]
    }

    var negative []int
    var zero bool
    var positive bool

    for _, g := range grades {
        if g < 0 {
            negative = append(negative, g)
        } else if g == 0 {
            zero = true
        } else {
            positive = true
        }
    }

    if len(negative)%2 == 0 {
        product := 1
        for _, g := range grades {
            product *= g
        }
        return product
    } else {
        if len(negative) == 1 && !positive && !zero {
            return 0
        }

        maxProduct := 1
        for _, g := range grades {
            maxProduct *= g
        }

        minNegative := negative[0]
        for _, n := range negative[1:] {
            if n > minNegative {
                minNegative = n
            }
        }

        return maxProduct / minNegative
    }
}