var alienOrder = function(words) {
    const graph = {};
    const inDegree = {};

    // Initialize graph and inDegree
    for (const word of words) {
        for (const char of word) {
            graph[char] = new Set();
            inDegree[char] = 0;
        }
    }

    // Build graph and inDegree
    for (let i = 0; i < words.length - 1; i++) {
        const word1 = words[i];
        const word2 = words[i + 1];
        const minLen = Math.min(word1.length, word2.length);

        if (word1.length > word2.length && word1.startsWith(word2)) {
            return "";
        }

        for (let j = 0; j < minLen; j++) {
            const char1 = word1[j];
            const char2 = word2[j];
            if (char1 !== char2) {
                if (!graph[char1].has(char2)) {
                    graph[char1].add(char2);
                    inDegree[char2]++;
                }
                break;
            }
        }
    }

    // Topological sort
    const queue = [];
    for (const char in inDegree) {
        if (inDegree[char] === 0) {
            queue.push(char);
        }
    }

    let result = [];
    while (queue.length > 0) {
        const char = queue.shift();
        result.push(char);
        for (const neighbor of graph[char]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    if (result.length !== Object.keys(inDegree).length) {
        return "";
    }

    return result.join('');
};