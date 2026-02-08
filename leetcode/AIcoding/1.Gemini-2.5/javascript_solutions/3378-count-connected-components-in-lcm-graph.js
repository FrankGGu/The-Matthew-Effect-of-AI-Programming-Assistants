var countConnectedComponents = function(n) {
    // The problem states that nodes are labeled from 1 to n.
    // An edge exists between two distinct nodes i and j if lcm(i, j) <= n.
    //
    // Consider node 1.
    // For any other node k, where 2 <= k <= n:
    // The least common multiple of 1 and k is lcm(1, k) = k.
    // Since k is a node in the graph, it must be that k <= n.
    // Therefore, the condition lcm(1, k) <= n is always true for any k in the range [2, n].
    //
    // This implies that node 1 is connected to every other node k (for k from 2 to n).
    // If node 1 is connected to all other nodes, then all nodes in the graph
    // (from 1 to n) must belong to the same connected component.
    //
    // Thus, for any n >= 1, there is always exactly 1 connected component.
    // If n = 1, there is only one node, so 1 component.
    // If n > 1, node 1 connects all other nodes, resulting in 1 component.
    return 1;
};