var flipAndInvertImage = function(A) {
    return A.map(row => row.reverse().map(bit => bit ^ 1));
};