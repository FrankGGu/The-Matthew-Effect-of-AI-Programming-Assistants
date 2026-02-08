var pathInZigZagTree = function(label) {
    let depth = Math.floor(Math.log2(label)) + 1;
    let result = [];
    while (depth > 0) {
        result.push(label);
        let maxLabel = (1 << depth) - 1;
        let minLabel = (1 << (depth - 1));
        label = (depth % 2 === 0) 
            ? maxLabel - (label - minLabel) / 2 
            : minLabel + (label - minLabel) / 2;
        depth--;
    }
    return result.reverse();
};