func pathInZigZagTree(label int) []int {
    level := 0
    for 1 << level <= label {
        level++
    }

    var res []int
    for label >= 1 {
        res = append([]int{label}, res...)
        level--
        label = (1 << level) + (1 << (level - 1)) - 1 - label / 2
    }
    return res
}