func connect(root *Node) *Node {
    if root == nil {
        return nil
    }

    head := root

    for head != nil {
        var currentLevelHead *Node
        var currentLevelPrev *Node

        p := head

        for p != nil {
            if p.Left != nil {
                if currentLevelPrev != nil {
                    currentLevelPrev.Next = p.Left
                } else {
                    currentLevelHead = p.Left
                }
                currentLevelPrev = p.Left
            }

            if p.Right != nil {
                if currentLevelPrev != nil {
                    currentLevelPrev.Next = p.Right
                } else {
                    currentLevelHead = p.Right
                }
                currentLevelPrev = p.Right
            }

            p = p.Next
        }

        head = currentLevelHead
    }

    return root
}