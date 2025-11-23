var partition = function(s) {
    const n = s.length;
    const result = [];
    const currentPartition = [];

    // Pre-compute all palindromic substrings using dynamic programming
    // isPalindrome[i][j] will be true if s[i...j] is a palindrome
    const isPalindrome = Array(n).fill(0).map(() => Array(n).fill(false));

    for (let i = n - 1; i >= 0; i--) {
        for (let j = i; j < n; j++) {
            if (s[i] === s[j] && (j - i <= 2 || isPalindrome[i + 1][j - 1])) {
                isPalindrome[i][j] = true;
            }
        }
    }

    // Backtracking function
    function backtrack(start) {
        // If we have processed the entire string, add the current partition to the results
        if (start === n) {
            result.push([...currentPartition]);
            return;
        }

        // Iterate through all possible end points for the current substring
        for (let i = start; i < n; i++) {
            // If the substring s[start...i] is a palindrome
            if (isPalindrome[start][i]) {
                // Add it to the current partition
                currentPartition.push(s.substring(start, i + 1));
                // Recurse for the rest of the string
                backtrack(i + 1);
                // Backtrack: remove the last added substring to explore other partitions
                currentPartition.pop();
            }
        }
    }

    backtrack(0);
    return result;
};