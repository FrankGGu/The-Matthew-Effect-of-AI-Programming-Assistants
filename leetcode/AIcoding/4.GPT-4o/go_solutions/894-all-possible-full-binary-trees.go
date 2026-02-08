package main

import "fmt"

type TreeNode struct {
    Left  *TreeNode
    Right *TreeNode
}

func allPossibleFBT(N int) []*TreeNode {
    if N%2 == 0 {
        return []*TreeNode{}
    }
    return allFBT(N)
}

func allFBT(N int) []*TreeNode {
    if N == 1 {
        return []*TreeNode{&TreeNode{}}
    }
    result := []*TreeNode{}
    for left := 1; left < N; left += 2 {
        right := N - 1 - left
        for _, l := range allFBT(left) {
            for _, r := range allFBT(right) {
                result = append(result, &TreeNode{Left: l, Right: r})
            }
        }
    }
    return result
}

func main() {
    fmt.Println(allPossibleFBT(7))
}