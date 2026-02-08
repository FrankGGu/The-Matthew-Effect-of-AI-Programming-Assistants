package main

func intervalIntersection(list1 [][]int, list2 [][]int) [][]int {
    result := [][]int{}
    i, j := 0, 0
    for i < len(list1) && j < len(list2) {
        start := max(list1[i][0], list2[j][0])
        end := min(list1[i][1], list2[j][1])
        if start <= end {
            result = append(result, []int{start, end})
        }
        if list1[i][1] < list2[j][1] {
            i++
        } else {
            j++
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}