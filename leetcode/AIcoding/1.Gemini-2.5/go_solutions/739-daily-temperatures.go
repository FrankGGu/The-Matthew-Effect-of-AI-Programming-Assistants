func dailyTemperatures(temperatures []int) []int {
    n := len(temperatures)
    ans := make([]int, n)

    // stack stores indices
    var stack []int 

    for i := 0; i < n; i++ {
        currentTemp := temperatures[i]