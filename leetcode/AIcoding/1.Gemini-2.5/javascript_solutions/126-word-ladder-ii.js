var findLadders = function(beginWord, endWord, wordList) {
    const wordSet = new Set(wordList);
    wordSet.add(beginWord); // Ensure beginWord is in the set for neighbor checks

    if (!wordSet.has(endWord)) {
        return [];
    }

    // Stores parents for each word: word -> Set<parent_word>
    const prev = new Map();
    // Stores shortest distance from beginWord to each word
    const dist = new Map();
    // Queue for BFS: [word]
    const q = [];

    q.push(beginWord);
    dist.set(beginWord, 0);
    let foundEnd = false;

    // BFS to build the graph (prev map) and find shortest distance
    while (q.length > 0 && !foundEnd) {
        const levelSize = q.length;
        // Words to be added to dist/prev in this level, to avoid processing them multiple times in the same level
        // and to ensure we only add parents from the *current* level.
        const wordsToVisitNextLevel = new Set(); 

        for (let i = 0; i < levelSize; i++) {
            const currentWord = q.shift();

            // If we've already found the endWord and currentWord's distance is greater than endWord's,
            // then this path is not a shortest path to endWord.
            if (foundEnd && dist.get(currentWord) >= dist.get(endWord)) {
                continue;
            }

            // Generate all possible next words
            for (let j = 0; j < currentWord.length; j++) {
                const originalChar = currentWord[j];
                for (let charCode = 97; charCode <= 122; charCode++) { // 'a' to 'z'
                    const char = String.fromCharCode(charCode);
                    if (char === originalChar) continue;

                    const nextWord = currentWord.substring(0, j) + char + currentWord.substring(j + 1);

                    if (wordSet.has(nextWord)) {
                        // Case 1: nextWord is not visited yet (first time reaching it)
                        if (!dist.has(nextWord)) {
                            dist.set(nextWord, dist.get(currentWord) + 1);
                            wordsToVisitNextLevel.add(nextWord); // Add to a temporary set for next level's queue

                            // Add currentWord as a parent of nextWord
                            if (!prev.has(nextWord)) {
                                prev.set(nextWord, new Set());
                            }
                            prev.get(nextWord).add(currentWord);

                            if (nextWord === endWord) {
                                foundEnd = true;
                            }
                        } 
                        // Case 2: nextWord has been visited, and we found another shortest path to it
                        else if (dist.get(nextWord) === dist.get(currentWord) + 1) {
                            // Add currentWord as another parent of nextWord
                            if (!prev.has(nextWord)) { 
                                prev.set(nextWord, new Set());
                            }
                            prev.get(nextWord).add(currentWord);
                        }
                        // Case 3: nextWord has been visited with a shorter path (dist.get(nextWord) < dist.get(currentWord) + 1)
                        // Do nothing, this is not a shortest path.
                    }
                }
            }
        }
        // After processing all words in the current level, add the new words found for the next level to the queue.
        // This ensures we process level by level correctly.
        for (const word of wordsToVisitNextLevel) {
            q.push(word);
        }
    }

    if (!foundEnd) {
        return [];
    }

    // DFS to reconstruct all paths
    const results = [];
    const path = []; // This will store the path in reverse order, then copied and reversed.

    function dfs(word) {
        path.push(word); // Add to the end of the path (building from endWord to beginWord)

        if (word === beginWord) {
            results.push([...path].reverse()); // Found a path, reverse it and add to results
        } else {
            if (prev.has(word)) { // Check if word has parents (it should if it's part of a valid path)
                for (const p of prev.get(word)) {
                    // Only follow parents that are exactly one step closer to beginWord.
                    if (dist.has(p) && dist.get(p) === dist.get(word) - 1) {
                         dfs(p);
                    }
                }
            }
        }
        path.pop(); // Backtrack: remove the word from the current path
    }

    dfs(endWord);
    return results;
};