function colorTheArray(n, queries) {
    const result = [];
    const colors = new Array(n).fill(0);
    let adjacentCount = 0;

    const countAdjacent = (index) => {
        let count = 0;
        if (index > 0 && colors[index] === colors[index - 1]) count++;
        if (index < n - 1 && colors[index] === colors[index + 1]) count++;
        return count;
    };

    for (const [index, color] of queries) {
        adjacentCount -= countAdjacent(index);
        colors[index] = color;
        adjacentCount += countAdjacent(index);
        result.push(adjacentCount);
    }

    return result;
}