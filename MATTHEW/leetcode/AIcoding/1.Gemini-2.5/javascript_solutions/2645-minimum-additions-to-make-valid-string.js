var addMinimum = function(word) {
    let minAdditions = 0;
    let expectedCharCode = 'a'.charCodeAt(0); // ASCII for 'a'

    for (let i = 0; i < word.length; i++) {
        const currentCharCode = word.charCodeAt(i);

        // While the current character in 'word' does not match the expected character
        // in the 'abc' sequence, we must add characters to bridge the gap.
        while (currentCharCode !== expectedCharCode) {
            minAdditions++;
            // Move to the next expected character in the 'abc' cycle
            // 'a' -> 'b', 'b' -> 'c', 'c' -> 'a'
            expectedCharCode = (expectedCharCode - 'a'.charCodeAt(0) + 1) % 3 + 'a'.charCodeAt(0);
        }

        // At this point, currentCharCode === expectedCharCode.
        // We matched the character from 'word', so we just advance the expected character
        // for the next iteration, effectively consuming the current character.
        expectedCharCode = (expectedCharCode - 'a'.charCodeAt(0) + 1) % 3 + 'a'.charCodeAt(0);
    }

    // After iterating through the entire word, we might have an incomplete 'abc' sequence.
    // If expectedCharCode is 'a', it means the last 'abc' sequence was completed. No additions needed.
    // If expectedCharCode is 'b', it means we matched 'a', and are now waiting for 'b'.
    // To complete the 'abc' sequence, we need to add 'b' and 'c'.
    if (expectedCharCode === 'b'.charCodeAt(0)) {
        minAdditions += 2;
    } 
    // If expectedCharCode is 'c', it means we matched 'a' and 'b', and are now waiting for 'c'.
    // To complete the 'abc' sequence, we need to add 'c'.
    else if (expectedCharCode === 'c'.charCodeAt(0)) {
        minAdditions++;
    }

    return minAdditions;
};