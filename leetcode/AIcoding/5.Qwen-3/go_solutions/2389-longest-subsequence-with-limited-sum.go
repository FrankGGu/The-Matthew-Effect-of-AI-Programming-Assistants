package main

func answerQueries(nums []int, queries []int) []int {
    sort.Ints(nums)
    res := make([]int, len(queries))
    for i := range queries {
        sum := 0
        count := 0
        for _, num := range nums {
            if sum+num > queries[i] {
                break
            }
            sum += num
            count++
        }
        res[i] = count
    }
    return res
}