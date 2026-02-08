package main

func maxDepthAfterSplit(problem string) int {
    depth := 0
    maxDepth := 0
    for _, c := range problem {
        if c == '(' {
            depth++
            if depth > maxDepth {
                maxDepth = depth
            }
        } else {
            depth--
        }
    }
    return maxDepth
}