package main

func verifyPostorder(postorder []int) bool {
    return helper(postorder, 0, len(postorder)-1)
}

func helper(postorder []int, left, right int) bool {
    if left >= right {
        return true
    }
    root := postorder[right]
    mid := left
    for mid <= right-1 && postorder[mid] < root {
        mid++
    }
    for i := mid; i <= right-1; i++ {
        if postorder[i] < root {
            return false
        }
    }
    return helper(postorder, left, mid-1) && helper(postorder, mid, right-1)
}