var longestBeautifulSubstring = function(word) {
    let maxLength = 0;
    let currentLength = 0;
    let vowelState = 0; // 0: 'a', 1: 'e', 2: 'i', 3: 'o', 4: 'u'
                        // This tracks the highest vowel index we have successfully reached in order.

    for (let i = 0; i < word.length; i++) {
        const char = word[i];
        let v_idx = -1;

        if (char === 'a') v_idx = 0;
        else if (char === 'e') v_idx = 1;
        else if (char === 'i') v_idx = 2;
        else if (char === 'o') v_idx = 3;
        else if (char === 'u') v_idx = 4;

        if (v_idx === -1) { // Not a vowel, reset the current sequence
            currentLength = 0;
            vowelState = 0;
            continue;
        }

        if (v_idx === vowelState) { // Current character is the same vowel as the current state (e.g., 'a' after 'a')
            currentLength++;
        } else if (v_idx === vowelState + 1) { // Current character is the next vowel in alphabetical order (e.g., 'e' after 'a')
            vowelState++;
            currentLength++;
        } else { // Order is broken (e.g., 'a' after 'e', or 'i' after 'a')
            if (v_idx === 0) { // If the character is 'a', we can start a new beautiful substring from here
                vowelState = 0;
                currentLength = 1;
            } else { // Any other vowel appearing out of order invalidates the current sequence
                vowelState = 0;
                currentLength = 0;
            }
        }

        // If we have successfully reached the 'u' state (all 5 vowels in order)
        if (vowelState === 4) {
            maxLength = Math.max(maxLength, currentLength);
        }
    }

    return maxLength;
};