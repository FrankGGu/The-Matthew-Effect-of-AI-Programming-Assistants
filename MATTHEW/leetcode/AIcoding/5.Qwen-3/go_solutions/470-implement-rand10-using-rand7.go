package main


func rand7() int

func rand10() int {
    for {
        row := rand7()
        col := rand7()
        idx := (row-1)*7 + col
        if idx <= 40 {
            return idx % 10 + 1
        }
    }
}