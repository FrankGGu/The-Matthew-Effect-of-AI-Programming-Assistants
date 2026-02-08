package main

func minCost(expression string) int {
    var stack []int
    var ops []byte

    for i := 0; i < len(expression); i++ {
        c := expression[i]
        if c == '0' || c == '1' {
            stack = append(stack, int(c-'0'))
        } else if c == '(' {
            ops = append(ops, c)
        } else if c == ')' {
            for len(ops) > 0 && ops[len(ops)-1] != '(' {
                performOp(stack, ops[len(ops)-1])
                ops = ops[:len(ops)-1]
            }
            ops = ops[:len(ops)-1]
        } else {
            for len(ops) > 0 && ops[len(ops)-1] != '(' {
                performOp(stack, ops[len(ops)-1])
                ops = ops[:len(ops)-1]
            }
            ops = append(ops, c)
        }
    }

    for len(ops) > 0 {
        performOp(stack, ops[len(ops)-1])
        ops = ops[:len(ops)-1]
    }

    return stack[0]
}

func performOp(stack []int, op byte) {
    b := stack[len(stack)-1]
    stack = stack[:len(stack)-1]
    a := stack[len(stack)-1]
    stack = stack[:len(stack)-1]

    var res int
    if op == '&' {
        res = a & b
    } else if op == '|' {
        res = a | b
    } else {
        res = a ^ b
    }

    stack = append(stack, res)
}