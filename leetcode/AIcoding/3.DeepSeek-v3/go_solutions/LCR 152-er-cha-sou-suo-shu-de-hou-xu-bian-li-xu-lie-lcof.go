func verifyPostorder(postorder []int) bool {
    var helper func(i, j int) bool
    helper = func(i, j int) bool {
        if i >= j {
            return true
        }
        p := i
        for postorder[p] < postorder[j] {
            p++
        }
        m := p
        for postorder[p] > postorder[j] {
            p++
        }
        return p == j && helper(i, m-1) && helper(m, j-1)
    }
    return helper(0, len(postorder)-1)
}