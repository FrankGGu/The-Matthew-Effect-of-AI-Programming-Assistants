func pathInZigZagTree(label int) []int {
    depth := 1
    nodeCount := 1
    for nodeCount*2 <= label {
        nodeCount *= 2
        depth++
    }

    path := make([]int, depth)
    path[depth-1] = label

    for i := depth - 2; i >= 0; i-- {
        label = (1<<uint(i+1) - 1) - (label/2 - (1<<uint(i)))
        path[i] = label
    }

    return path
}