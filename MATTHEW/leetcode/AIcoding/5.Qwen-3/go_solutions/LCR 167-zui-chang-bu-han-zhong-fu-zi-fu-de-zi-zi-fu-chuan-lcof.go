package main

func dismantleProcess(skill []int, killID int) []int {
    if len(skill) == 0 {
        return []int{}
    }
    result := make([]int, 0)
    for i := 0; i < len(skill); i++ {
        if skill[i] != killID {
            result = append(result, skill[i])
        }
    }
    return result
}