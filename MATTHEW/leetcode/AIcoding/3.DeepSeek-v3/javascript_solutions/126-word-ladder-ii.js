var findLadders = function(beginWord, endWord, wordList) {
    const wordSet = new Set(wordList);
    if (!wordSet.has(endWord)) return [];

    const adjacency = {};
    const distance = {};
    const result = [];

    const queue = [beginWord];
    distance[beginWord] = 0;

    while (queue.length > 0) {
        const current = queue.shift();
        if (current === endWord) break;

        for (let i = 0; i < current.length; i++) {
            for (let c = 'a'.charCodeAt(0); c <= 'z'.charCodeAt(0); c++) {
                const next = current.substring(0, i) + String.fromCharCode(c) + current.substring(i + 1);
                if (wordSet.has(next)) {
                    if (distance[next] === undefined) {
                        distance[next] = distance[current] + 1;
                        queue.push(next);
                        adjacency[next] = [current];
                    } else if (distance[next] === distance[current] + 1) {
                        adjacency[next].push(current);
                    }
                }
            }
        }
    }

    function dfs(path, node) {
        if (node === beginWord) {
            result.push([...path].reverse());
            return;
        }
        if (!adjacency[node]) return;
        for (const parent of adjacency[node]) {
            path.push(parent);
            dfs(path, parent);
            path.pop();
        }
    }

    dfs([endWord], endWord);
    return result;
};