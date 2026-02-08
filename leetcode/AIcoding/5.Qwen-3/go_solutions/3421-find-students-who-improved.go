package main

func findStudentsWhoImproved(student_performance []int) []int {
    result := make([]int, 0)
    for i := 0; i < len(student_performance); i++ {
        if i == 0 {
            continue
        }
        if student_performance[i] > student_performance[i-1] {
            result = append(result, i)
        }
    }
    return result
}