var shortestBeautifulString = function(s, k, target) {
    let minBeautifulString = "";
    const n = s.length;

    if (k > n) {
        return "";
    }

    let currentOnes = 0;
    // Calculate ones for the first window
    for (let i = 0; i < k; i++) {
        if (s[i] === '1') {
            currentOnes++;
        }
    }

    // Check the first window
    if (currentOnes === target) {
        minBeautifulString = s.substring(0, k);
    }

    // Slide the window
    for (let i = 1; i <= n - k; i++) {
        // Update currentOnes by removing the leftmost character and adding the new rightmost character
        if (s[i - 1] === '1') {
            currentOnes--;
        }
        if (s[i + k - 1] === '1') {
            currentOnes++;
        }

        // If the current window is beautiful
        if (currentOnes === target) {
            const currentSub = s.substring(i, i + k);
            if (minBeautifulString === "") {
                minBeautifulString = currentSub;
            } else {
                // All beautiful strings have the same length k, so we only compare lexicographically
                if (currentSub < minBeautifulString) {
                    minBeautifulString = currentSub;
                }
            }
        }
    }

    return minBeautifulString;
};