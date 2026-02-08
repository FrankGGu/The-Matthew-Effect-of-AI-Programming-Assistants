func separateSquares(nums []int) [][]int {
    var res [][]int
    var current []int

    for _, num := range nums {
        if isPerfectSquare(num) {
            if len(current) > 0 && !isPerfectSquare(current[len(current)-1]) {
                res = append(res, current)
                current = []int{}
            }
            current = append(current, num)
        } else {
            if len(current) > 0 && isPerfectSquare(current[len(current)-1]) {
                res = append(res, current)
                current = []int{}
            }
            current = append(current, num)
        }
    }

    if len(current) > 0 {
        res = append(res, current)
    }

    return res
}

func isPerfectSquare(num int) bool {
    if num < 0 {
        return false
    }
    root := int(math.Sqrt(float64(num)))
    return root*root == num
}