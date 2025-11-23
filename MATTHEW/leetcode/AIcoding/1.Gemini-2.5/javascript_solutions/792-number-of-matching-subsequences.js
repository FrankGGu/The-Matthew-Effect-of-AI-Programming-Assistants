var numMatchingSubsequences = function(s, words) {
    let count = 0;
    const queues = Array(26).fill(null).map(() => []); // queues[0] for 'a', queues[1] for 'b', etc.
                                                      // Each queue stores [word_index, current_char_index_in_word]

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        if (word.length === 0) {
            count++;
        } else {
            const charCode = word.charCodeAt(0) - 'a'.charCodeAt(0);
            queues[charCode].push([i, 0]);
        }
    }

    for (const char_s of s) {
        const charCode_s = char_s.charCodeAt(0) - 'a'.charCodeAt(0);

        // Take all words currently waiting for char_s
        const wordsWaitingForThisChar = queues[charCode_s];

        // Clear the current bucket for the next iteration of s
        // This is important because we are processing all words that need char_s
        // and moving them to their next required character's bucket.
        queues[charCode_s] = []; 

        for (const [wordIndex, charIndexInWord] of wordsWaitingForThisChar) {
            const nextCharIndexInWord = charIndexInWord + 1;

            if (nextCharIndexInWord === words[wordIndex].length) {
                // This word has been fully matched as a subsequence
                count++;
            } else {
                // This word still has characters remaining.
                // Move it to the queue corresponding to its next required character.
                const nextCharInWord = words[wordIndex][nextCharIndexInWord];
                const nextCharCodeInWord = nextCharInWord.charCodeAt(0) - 'a'.charCodeAt(0);
                queues[nextCharCodeInWord].push([wordIndex, nextCharIndexInWord]);
            }
        }
    }

    return count;
};