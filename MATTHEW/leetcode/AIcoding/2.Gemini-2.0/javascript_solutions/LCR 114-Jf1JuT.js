var alienOrder = function(words) {
    const adj = new Map();
    const indegree = new Map();

    for (const word of words) {
        for (const char of word) {
            adj.set(char, []);
            indegree.set(char, 0);
        }
    }

    for (let i = 0; i < words.length - 1; i++) {
        const word1 = words[i];
        const word2 = words[i + 1];
        const minLen = Math.min(word1.length, word2.length);

        for (let j = 0; j < minLen; j++) {
            if (word1[j] !== word2[j]) {
                if (!adj.get(word1[j]).includes(word2[j])) {
                    adj.get(word1[j]).push(word2[j]);
                    indegree.set(word2[j], indegree.get(word2[j]) + 1);
                }
                break;
            }

            if (j === minLen - 1 && word1.length > word2.length) {
                return "";
            }
        }
    }

    const queue = [];
    for (const [char, degree] of indegree) {
        if (degree === 0) {
            queue.push(char);
        }
    }

    let result = "";
    while (queue.length > 0) {
        const char = queue.shift();
        result += char;

        for (const neighbor of adj.get(char)) {
            indegree.set(neighbor, indegree.get(neighbor) - 1);
            if (indegree.get(neighbor) === 0) {
                queue.push(neighbor);
            }
        }
    }

    if (result.length !== indegree.size) {
        return "";
    }

    return result;
};