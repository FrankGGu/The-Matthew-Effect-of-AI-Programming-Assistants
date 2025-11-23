func leafSimilar(root1 *TreeNode, root2 *TreeNode) bool {
    var getLeafSequence func(node *TreeNode, sequence *[]int)
    getLeafSequence = func(node *TreeNode) {
        if node == nil {
            return
        }
        if node.Left == nil && node.Right == nil {
            *sequence = append(*sequence, node.Val)
            return
        }
        getLeafSequence(node.Left, sequence)
        getLeafSequence(node.Right, sequence)
    }

    seq1 := []int{}
    getLeafSequence(root1, &seq1)

    seq2 := []int{}
    getLeafSequence(root2, &seq2)

    if len(seq1) != len(seq2) {
        return false
    }

    for i := 0; i < len(seq1); i++ {
        if seq1[i] != seq2[i] {
            return false
        }
    }

    return true
}