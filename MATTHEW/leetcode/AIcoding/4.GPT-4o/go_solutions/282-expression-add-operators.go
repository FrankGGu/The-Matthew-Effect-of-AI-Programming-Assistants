func addOperators(num string, target int) []string {
    var res []string
    var backtrack func(path string, pos int, prev int, curr int)

    backtrack = func(path string, pos int, prev int, curr int) {
        if pos == len(num) {
            if curr == target {
                res = append(res, path)
            }
            return
        }

        for i := pos; i < len(num); i++ {
            if num[pos] == '0' && i > pos {
                break
            }
            nextNum, _ := strconv.Atoi(num[pos : i+1])
            if pos == 0 {
                backtrack(path+strconv.Itoa(nextNum), i+1, nextNum, nextNum)
            } else {
                backtrack(path+"+"+strconv.Itoa(nextNum), i+1, nextNum, curr+nextNum)
                backtrack(path+"-"+strconv.Itoa(nextNum), i+1, -nextNum, curr-nextNum)
                backtrack(path+"*"+strconv.Itoa(nextNum), i+1, prev*nextNum, curr-prev+prev*nextNum)
            }
        }
    }

    backtrack("", 0, 0, 0)
    return res
}