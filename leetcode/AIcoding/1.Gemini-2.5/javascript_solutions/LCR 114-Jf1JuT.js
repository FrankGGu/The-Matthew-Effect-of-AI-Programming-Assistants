var alienOrder = function(words) {
    if (!words || words.length === 0) {
        return "";
    }

    const adj = new Map();
    const inDegree = new Map();

    // Initialize all unique characters with 0 in-degree and empty adjacency lists
    for (const word of words) {
        for (const char of word) {
            if (!inDegree.has(char)) {
                inDegree.set(char, 0);
                adj.set(char, new Set());
            }
        }
    }

    // Build the graph and calculate in-degrees
    for (let i = 0; i < words.length - 1; i++) {
        const word1 = words[i];
        const word2 = words[i + 1];

        // Check for invalid order like "abc", "ab"
        if (word1.length > word2.length && word1.startsWith(word2)) {
            return "";
        }

        let foundDiff = false;
        for (let j = 0; j < Math.min(word1.length, word2.length); j++) {
            const char1 = word1[j];
            const char2 = word2[j];
            if (char1 !== char2) {
                // If char1 -> char2 edge doesn't exist, add it
                if (!adj.get(char1).has(char2)) {
                    adj.get(char1).add(char2);
                    inDegree.set(char2, inDegree.get(char2) + 1);
                }
                foundDiff = true;
                break;
            }
        }
    }

    // Perform topological sort using Kahn's algorithm (BFS)
    const queue = [];
    for (const [char, degree] of inDegree.entries()) {
        if (degree === 0) {
            queue.push(char);
        }
    }

    let result = "";
    while (queue.length > 0) {
        const u = queue.shift();
        result += u;

        for (const v of adj.get(u)) {
            inDegree.set(v, inDegree.get(v) - 1);
            if (inDegree.get(v) === 0) {
                queue.push(v);
            }
        }
    }

    // If the length of the result string is not equal to the total number of unique characters,
    // it means there was a cycle, and no valid order exists.
    if (result.length === inDegree.size) {
        return result;
    } else {
        return "";
    }
};