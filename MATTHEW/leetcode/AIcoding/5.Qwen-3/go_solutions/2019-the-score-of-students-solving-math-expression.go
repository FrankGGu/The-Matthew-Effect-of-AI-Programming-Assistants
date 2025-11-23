package main

func scoreOfStudents(s string) int {
    var stack []int
    var nums []int
    var ops []byte

    for i := 0; i < len(s); i++ {
        if s[i] == ' ' {
            continue
        }
        if s[i] >= '0' && s[i] <= '9' {
            nums = append(nums, int(s[i]-'0'))
        } else {
            ops = append(ops, s[i])
        }
    }

    for i := 0; i < len(nums); i++ {
        stack = append(stack, nums[i])
        if i < len(ops) {
            op := ops[i]
            if op == '+' {
                stack = append(stack, 0)
            } else if op == '*' {
                stack = append(stack, 1)
            }
        }
    }

    for i := 0; i < len(stack); i += 2 {
        if i+1 < len(stack) && stack[i+1] == 1 {
            stack[i+2] = stack[i] * stack[i+2]
            stack = append(stack[:i], stack[i+3:]...)
            i -= 2
        }
    }

    res := 0
    for i := 0; i < len(stack); i += 2 {
        res += stack[i]
    }

    if res > 100 {
        return 0
    }

    return res
}