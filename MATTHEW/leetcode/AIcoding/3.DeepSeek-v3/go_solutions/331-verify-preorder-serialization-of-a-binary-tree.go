func isValidSerialization(preorder string) bool {
    slots := 1
    for i := 0; i < len(preorder); {
        if slots == 0 {
            return false
        }
        if preorder[i] == ',' {
            i++
        } else if preorder[i] == '#' {
            slots--
            i++
        } else {
            for i < len(preorder) && preorder[i] != ',' {
                i++
            }
            slots++
        }
    }
    return slots == 0
}