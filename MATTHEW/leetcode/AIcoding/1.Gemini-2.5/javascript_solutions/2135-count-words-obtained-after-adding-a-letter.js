var countWords = function(startWords, targetWords) {
    // Helper function to convert a word to its frequency array
    // Each index corresponds to a letter 'a' through 'z'
    // The value at an index is the count of that letter in the word
    const wordToFreqArray = (word) => {
        const freq = new Array(26).fill(0);
        for (let i = 0; i < word.length; i++) {
            freq[word.charCodeAt(i) - 97]++; // 97 is the ASCII char code for 'a'
        }
        return freq;
    };

    // Helper function to convert a frequency array to a unique string key
    // This allows using the frequency array as a key in a Set for efficient lookups
    const freqArrayToKey = (freq) => {
        return freq.join('#'); // Using '#' as a separator to prevent ambiguity (e.g., [1,10] vs [11,0])
    };

    // Store the unique frequency array keys of all start words in a Set
    const startWordFreqKeys = new Set();
    for (const word of startWords) {
        const freq = wordToFreqArray(word);
        startWordFreqKeys.add(freqArrayToKey(freq));
    }

    let count = 0;

    // Iterate through each target word
    for (const targetWord of targetWords) {
        // Convert the target word to its frequency array
        const targetFreq = wordToFreqArray(targetWord);

        // Try removing each possible character ('a' through 'z') from the target word
        // and check if the resulting word (represented by its frequency array)
        // exists in our set of start words.
        for (let i = 0; i < 26; i++) { // i represents the character 'a' + i
            // Check if the target word actually contains this character
            if (targetFreq[i] > 0) {
                // Temporarily decrement the count of the current character 'i'
                // This simulates removing one instance of this character from the target word
                targetFreq[i]--;

                // Check if the frequency array (representing the word after removing a character)
                // matches any of the start words' frequency arrays
                if (startWordFreqKeys.has(freqArrayToKey(targetFreq))) {
                    count++; // If a match is found, increment the counter
                    break;   // Move to the next target word, as one match is sufficient
                }

                // Backtrack: restore the count of the character 'i'
                // This is crucial to correctly test removing other characters from the original target word
                targetFreq[i]++;
            }
        }
    }

    return count;
};