type TreeNode struct {
    Val int
    Left *TreeNode
    Right *TreeNode
}

type Operation struct {
    Type int
    X int
    Y int
}

func getNumber(root *TreeNode, ops [][]int) int {
    nodes := make([]int, 0)
    inorder(root, &nodes)

    uf := make([]int, len(nodes))
    for i := range uf {
        uf[i] = i
    }

    res := make([]bool, len(nodes))

    for i := len(ops)-1; i >= 0; i-- {
        op := ops[i]
        t, x, y := op[0], op[1], op[2]
        left := lowerBound(nodes, x)
        right := upperBound(nodes, y) - 1
        if left > right {
            continue
        }

        for j := find(uf, left); j <= right; j = find(uf, j+1) {
            if t == 1 {
                res[j] = true
            } else {
                res[j] = false
            }
            uf[j] = j + 1
        }
    }

    count := 0
    for _, v := range res {
        if v {
            count++
        }
    }
    return count
}

func inorder(root *TreeNode, nodes *[]int) {
    if root == nil {
        return
    }
    inorder(root.Left, nodes)
    *nodes = append(*nodes, root.Val)
    inorder(root.Right, nodes)
}

func lowerBound(nums []int, target int) int {
    left, right := 0, len(nums)
    for left < right {
        mid := left + (right - left) / 2
        if nums[mid] >= target {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func upperBound(nums []int, target int) int {
    left, right := 0, len(nums)
    for left < right {
        mid := left + (right - left) / 2
        if nums[mid] > target {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func find(uf []int, x int) int {
    if uf[x] != x {
        uf[x] = find(uf, uf[x])
    }
    return uf[x]
}