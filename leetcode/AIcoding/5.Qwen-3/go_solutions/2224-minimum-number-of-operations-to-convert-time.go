package main

func convertTime(time string) int {
    target := 0
    for i, c := range time {
        if i == 0 {
            target += int(c-'0') * 3600
        } else if i == 1 {
            target += int(c-'0') * 60
        } else if i == 3 {
            target += int(c-'0') * 60
        } else if i == 4 {
            target += int(c-'0')
        }
    }

    operations := 0
    for _, t := range []int{3600, 60, 15, 5, 1} {
        if target >= t {
            operations += target / t
            target %= t
        }
    }
    return operations
}