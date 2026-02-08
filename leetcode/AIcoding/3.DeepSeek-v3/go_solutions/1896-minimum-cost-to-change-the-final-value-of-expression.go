func minOperationsToFlip(expression string) int {
    n := len(expression)
    stack := []int{}
    pair := make([]int, n)
    for i := 0; i < n; i++ {
        if expression[i] == '(' {
            stack = append(stack, i)
        } else if expression[i] == ')' {
            j := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            pair[i] = j
            pair[j] = i
        }
    }

    var dfs func(l, r int) [3]int
    dfs = func(l, r int) [3]int {
        if l == r {
            val := int(expression[l] - '0')
            return [3]int{val, val ^ 1, 1}
        }
        var left, right [3]int
        if expression[r] == ')' && pair[r] == l {
            return dfs(l+1, r-1)
        }
        k := -1
        if expression[r] == ')' {
            k = pair[r] - 1
        } else {
            k = r - 1
        }
        left = dfs(l, k-1)
        right = dfs(k+1, r)
        op := expression[k]
        var res [3]int
        if op == '&' {
            res[0] = left[0] & right[0]
            res[1] = left[1] | right[1]
            if left[0] == 1 && right[0] == 1 {
                res[2] = min(left[2], right[2])
            } else if left[0] == 0 && right[0] == 0 {
                res[2] = min(left[2]+right[2], min(left[2], right[2])+1
            } else {
                res[2] = 1
            }
        } else if op == '|' {
            res[0] = left[0] | right[0]
            res[1] = left[1] & right[1]
            if left[0] == 0 && right[0] == 0 {
                res[2] = min(left[2], right[2])
            } else if left[0] == 1 && right[0] == 1 {
                res[2] = min(left[2]+right[2], min(left[2], right[2])+1)
            } else {
                res[2] = 1
            }
        }
        return res
    }

    result := dfs(0, n-1)
    if result[0] == result[1] {
        return 0
    }
    return result[2]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}