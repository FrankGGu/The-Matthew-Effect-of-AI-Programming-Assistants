var lastVisitedIntegers = function(words) {
    const visited = [];
    const result = [];
    let k = 0;

    for (const word of words) {
        if (word === 'prev') {
            k++;
            if (visited.length - k < 0) {
                result.push(-1);
            } else {
                result.push(visited[visited.length - k]);
            }
        } else {
            visited.push(parseInt(word));
            k = 0;
        }
    }

    return result;
};