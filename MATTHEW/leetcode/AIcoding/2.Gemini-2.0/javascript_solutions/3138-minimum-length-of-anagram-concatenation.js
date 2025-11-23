var minimumLength = function(words) {
    let n = words.length;
    let adj = Array(n).fill(null).map(() => []);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            if (isAnagramPrefixSuffix(words[i], words[j])) {
                adj[i].push(j);
            }
        }
    }

    let visited = Array(n).fill(false);
    let minLen = Infinity;

    function dfs(start, path, currentLen) {
        visited[start] = true;
        path.push(start);

        let isTerminal = true;
        for (let neighbor of adj[start]) {
            if (!visited[neighbor]) {
                isTerminal = false;
                dfs(neighbor, path, currentLen);
            }
        }

        if (isTerminal) {
            let totalLen = 0;
            for (let i = 0; i < path.length; i++) {
                if (i === 0) {
                    totalLen += words[path[i]].length;
                } else {
                    let overlap = calculateOverlap(words[path[i-1]], words[path[i]]);
                    totalLen += (words[path[i]].length - overlap);
                }
            }
            minLen = Math.min(minLen, totalLen);
        }

        path.pop();
        visited[start] = false;
    }

    for (let i = 0; i < n; i++) {
        visited = Array(n).fill(false);
        dfs(i, [], 0);
    }

    return minLen;

    function isAnagramPrefixSuffix(word1, word2) {
        if (word1.length > word2.length) return false;
        let sortedWord1 = word1.split('').sort().join('');
        let sortedWord2 = word2.slice(0, word1.length).split('').sort().join('');
        return sortedWord1 === sortedWord2;
    }

    function calculateOverlap(word1, word2) {
        let overlap = 0;
        for (let i = 1; i <= Math.min(word1.length, word2.length); i++) {
            if (word1.slice(word1.length - i) === word2.slice(0, i)) {
                overlap = i;
            }
        }
        return overlap;
    }
};