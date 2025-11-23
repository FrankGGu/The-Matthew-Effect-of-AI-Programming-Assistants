class TrieNode {
    constructor() {
        this.children = new Map();
        this.wordIndex = -1; // Stores the index of the word that ends at this node
        // Stores indices of words whose *prefix* (from this point in the reversed word's path) is a palindrome.
        // More precisely, if the path from the root to this node represents `reverse(S)`,
        // and the original word was `P + S`, then `palindromeIndices` stores the index of this word
        // if `P` is a palindrome.
        this.palindromeIndices = []; 
    }
}

function isPalindrome(s) {
    let left = 0;
    let right = s.length - 1;
    while (left < right) {
        if (s[left] !== s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

function palindromePairs(words) {
    const root = new TrieNode();
    const results = new Set(); // Use a Set to store unique pairs as strings "i,j"

    let emptyIdx = -1;
    for (let i = 0; i < words.length; i++) {
        if (words[i] === "") {
            emptyIdx = i;
            break;
        }
    }

    // Build the Trie with reversed words
    // For each word `w` at `idx`, we insert `reverse(w)` into the Trie.
    // At each step `k` while inserting `reverse(w)`, the current node `curr` corresponds to `reverse(w_suffix)`.
    // If the *remaining prefix* `w_prefix` (which is `w.substring(0, k+1)`) of the original word `w` is a palindrome,
    // we store `idx` in `curr.palindromeIndices`.
    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        if (word === "") continue; // Empty string handled separately

        let curr = root;
        // Iterate through the word in reverse to build the Trie
        for (let k = word.length - 1; k >= 0; k--) {
            // `word.substring(0, k + 1)` is the prefix of the original word `word`
            // from index 0 up to and including index `k`.
            if (isPalindrome(word.substring(0, k + 1))) {
                curr.palindromeIndices.push(i);
            }
            const char = word[k];
            if (!curr.children.has(char)) {
                curr.children.set(char, new TrieNode());
            }
            curr = curr.children.get(char);
        }
        curr.wordIndex = i;
        // The entire word itself is considered a palindrome (empty prefix)
        curr.palindromeIndices.push(i); 
    }

    // Handle empty string case:
    // If "" exists at emptyIdx, then for any word `w` that is a palindrome,
    // `"" + w` and `w + ""` are palindromes.
    if (emptyIdx !== -1) {
        for (let i = 0; i < words.length; i++) {
            if (i === emptyIdx) continue; // Don't pair "" with itself
            if (isPalindrome(words[i])) {
                results.add(`${emptyIdx},${i}`);
                results.add(`${i},${emptyIdx}`);
            }
        }
    }

    // Search for other palindrome pairs
    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        if (word === "") continue; // Empty string already handled

        let curr = root;
        for (let k = 0; k < word.length; k++) {
            // Case 1: `words[j] + words[i]` forms a palindrome
            // This happens if `words[i] = prefix_i + suffix_i`, where `suffix_i` is a palindrome,
            // and `words[j] = reverse(prefix_i)`.
            // In the Trie, `curr` represents `reverse(prefix_i)`. So `curr.wordIndex` would be `j`.
            // `word.substring(k)` is `suffix_i`.
            if (curr.wordIndex !== -1 && curr.wordIndex !== i && isPalindrome(word.substring(k))) {
                results.add(`${curr.wordIndex},${i}`);
            }

            const char = word[k];
            if (!curr.children.has(char)) {
                curr = null; // No path found, break
                break;
            }
            curr = curr.children.get(char);
        }

        if (curr) {
            // Case 2: `words[i] + words[j]` forms a palindrome, where `words[i]` and `words[j]` have equal length.
            // This means `words[j] = reverse(words[i])`.
            // After traversing `words[i]` fully, `curr.wordIndex` would be `j` if `reverse(words[j])` matches `words[i]`.
            if (curr.wordIndex !== -1 && curr.wordIndex !== i) {
                results.add(`${i},${curr.wordIndex}`);
            }

            // Case 3: `words[i] + words[j]` forms a palindrome, where `words[j]` is longer.
            // This happens if `words[j] = prefix_j + suffix_j`, where `prefix_j = reverse(words[i])` and `suffix_j` is a palindrome.
            // The `palindromeIndices` at `curr` node stores indices `j` such that `words[j]` has a prefix (of `words[j]`) that is a palindrome,
            // AND `reverse(words[j])` has `words[i]` as a prefix.
            // More precisely, `curr.palindromeIndices` contains indices `j` where `words[j]` can be split into `P + reverse(words[i])`
            // where `P` is a palindrome.
            // So, `words[i] + words[j]` becomes `words[i] + P + reverse(words[i])`, which is a palindrome.
            for (const j of curr.palindromeIndices) {
                if (j !== i) {
                    results.add(`${i},${j}`);
                }
            }
        }
    }

    // Convert the Set of stringified pairs back to an array of number arrays
    return Array.from(results).map(pairStr => pairStr.split(',').map(Number));
}