var findCenter = function(edges) {
    const u1 = edges[0][0];
    const v1 = edges[0][1];
    const u2 = edges[1][0];
    const v2 = edges[1][1];

    if (u1 === u2 || u1 === v2) {
        return u1;
    } else {
        return v1;
    }
};