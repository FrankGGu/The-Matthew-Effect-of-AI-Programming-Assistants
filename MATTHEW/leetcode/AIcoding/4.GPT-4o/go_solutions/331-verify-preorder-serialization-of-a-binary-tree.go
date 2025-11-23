func isValidSerialization(preorder string) bool {
    slots := 1
    for i := 0; i < len(preorder); i++ {
        if preorder[i] == ',' {
            slots--
            if slots < 0 {
                return false
            }
            slots += 2
        }
    }
    return slots == 0
}