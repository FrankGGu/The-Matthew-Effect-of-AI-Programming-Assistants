func verifyPostorder(postorder []int) bool {
    return verify(postorder, 0, len(postorder)-1)
}

func verify(postorder []int, start, end int) bool {
    if start >= end {
        return true
    }
    root := postorder[end]
    split := start
    for split < end && postorder[split] < root {
        split++
    }
    for i := split; i < end; i++ {
        if postorder[i] < root {
            return false
        }
    }
    return verify(postorder, start, split-1) && verify(postorder, split, end-1)
}