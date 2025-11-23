function findCenter(edges) {
    const first = edges[0][0];
    const second = edges[0][1];
    if (edges[1][0] === first || edges[1][1] === first) {
        return first;
    } else {
        return second;
    }
}