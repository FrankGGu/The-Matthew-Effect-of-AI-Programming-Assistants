var repeatLimitedString = function(s, repeatLimit) {
    const counts = new Array(26).fill(0);
    for (const char of s) {
        counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const result = [];

    let i = 25; // Index for the current largest character (from 'z' down to 'a')

    while (i >= 0) {
        // If no instances of the current character 'i', move to the next smaller character
        if (counts[i] === 0) {
            i--;
            continue;
        }

        // Append character 'i' up to repeatLimit times or until all instances are used
        let appendedCount = 0;
        while (appendedCount < repeatLimit && counts[i] > 0) {
            result.push(String.fromCharCode('a'.charCodeAt(0) + i));
            counts[i]--;
            appendedCount++;
        }

        // If we still have instances of character 'i' left (meaning we hit the repeatLimit)
        if (counts[i] > 0) {
            // Find the next largest character 'j' that is available and smaller than 'i'
            let j = i - 1;
            while (j >= 0 && counts[j] === 0) {
                j--;
            }

            if (j >= 0) { // If a smaller character 'j' is found
                // Append one instance of character 'j' to break the sequence of 'i's
                result.push(String.fromCharCode('a'.charCodeAt(0) + j));
                counts[j]--;
                // After appending 'j', we can potentially use character 'i' again.
                // The loop will continue with the same 'i'.
            } else {
                // No smaller character available to break the sequence.
                // We cannot append character 'i' anymore, and no other characters can be appended.
                break; // Exit the main while loop
            }
        } else {
            // All instances of character 'i' have been used, or we didn't hit repeatLimit.
            // Move to the next largest character.
            i--;
        }
    }

    return result.join('');
};