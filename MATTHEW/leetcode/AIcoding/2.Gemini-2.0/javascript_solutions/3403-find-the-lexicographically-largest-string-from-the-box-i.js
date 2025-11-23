var findLexSmallestString = function(boxes) {
    let s = "";
    for (let i = 0; i < boxes.length; i++) {
        for (let j = 0; j < boxes[i]; j++) {
            s += String.fromCharCode(97 + i);
        }
    }
    return s;
};