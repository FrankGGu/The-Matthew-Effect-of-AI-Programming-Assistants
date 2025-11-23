var minInsertions = function(s) {
    let openCount = 0; // Tracks the number of open '(' that are currently waiting for their ')' counterparts.
                       // Each '(' needs a '))' pair.
    let insertions = 0; // Total number of insertions needed.

    let k = 0; // Current index for iterating through the string
    while (k < s.length) {
        if (s[k] === '(') {
            openCount++;
            k++;
        } else { // s[k] === ')'
            // Try to match this ')' with an open '('
            if (openCount > 0) {
                openCount--; // This ')' matches one ')' for an open '('
            } else {
                // No open '(' to match this ')'. We must insert a '('.
                insertions++; // Insert '('
                // After inserting '(', we conceptually have an open '(' that needs a '))'.
                // The current ')' will provide one of them. So, we still need one ')' for this conceptually inserted '('.
                // This means 'openCount' effectively becomes 1.
                openCount++; 
            }

            // Now, check if there's a second ')' to complete the pair '))'
            if (k + 1 < s.length && s[k+1] === ')') {
                k += 2; // Consume both ')' characters
            } else {
                // Only one ')' is available (s[k]). We need to insert another ')'.
                insertions++; // Insert ')'
                k++; // Consume the current ')'
            }
        }
    }

    // After iterating through the string, any remaining open '(' must be closed.
    // Each remaining 'openCount' represents an open '(' that still needs a '))' pair.
    // Since 'openCount' was decremented by 1 for each ')' found, and incremented by 1 for an inserted '(',
    // a remaining 'openCount' of X means X open '(' characters, each needing two ')' insertions.
    insertions += openCount * 2;
    return insertions;
};