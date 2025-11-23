package main

func minimumTeachStudents(people []string) int {
    if len(people) == 0 {
        return 0
    }
    n := len(people)
    m := len(people[0])
    teach := make(map[rune]bool)
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if people[i][j] == '1' {
                teach[rune(j)] = true
            }
        }
    }
    count := 0
    for j := 0; j < m; j++ {
        if !teach[rune(j)] {
            count++
        }
    }
    return count
}