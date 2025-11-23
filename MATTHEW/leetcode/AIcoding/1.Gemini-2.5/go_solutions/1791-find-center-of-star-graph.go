func findCenter(edges [][]int) int {
    // The center node must be present in every edge.
    // We can pick any two edges and find their common node.
    // That common node will be the center.

    // Get the first edge
    u1, v1 := edges[0][0], edges[0][1]

    // Get the second edge
    u2, v2 := edges[1][0], edges[1][1]

    // Check if u1 is common with u2 or v2
    if u1 == u2 || u1 == v2 {
        return u1
    } else {
        // If u1 is not the center, then v1 must be the center
        return v1
    }
}